//
//  CoreXLSX.swift
//  CoreXLSX
//
//  Created by Max Desiatov on 27/10/2018.
//

import Foundation
import XMLCoder
import ZIPFoundation

@available(*, deprecated, renamed: "CoreXLSXError")
public typealias XLSXReaderError = CoreXLSXError

public enum CoreXLSXError: Error {
  case archiveEntryNotFound
  case invalidCellReference
  case unsupportedWorksheetPath
}

public struct XLSXFile {
  public let filepath: String
  private let archive: Archive
  private let decoder: XMLDecoder

  /// Buffer size passed to `archive.extract` call
  private let bufferSize: UInt32

  /// - Parameters:
  ///   - filepath: path to the `.xlsx` file to be processed.
  ///   - bufferSize: ZIP archive buffer size in bytes. The default is 10KB.
  /// You may need to set a bigger buffer size for bigger files.
  ///   - errorContextLength: The error context length. The default is `0`.
  /// Non-zero length makes an error thrown from
  /// the XML parser with line/column location repackaged with a context
  /// around that location of specified length. For example, if an error was
  /// thrown indicating that there's an unexpected character at line 3, column
  /// 15 with `errorContextLength` set to 10, a new error type is rethrown
  /// containing 5 characters before column 15 and 5 characters after, all on
  /// line 3. Line wrapping should be handled correctly too as the context can
  /// span more than a few lines.
  public init?(filepath: String,
               bufferSize: UInt32 = 10 * 1024 * 1024,
               errorContextLength: UInt = 0) {
    let archiveURL = URL(fileURLWithPath: filepath)

    guard let archive = Archive(url: archiveURL, accessMode: .read) else {
      return nil
    }

    self.archive = archive
    self.filepath = filepath
    self.bufferSize = bufferSize

    let decoder = XMLDecoder()
    decoder.trimValueWhitespaces = false
    decoder.errorContextLength = errorContextLength
    decoder.shouldProcessNamespaces = true
    self.decoder = decoder
  }

  /// Parse a file within `archive` at `path`. Parsing result is
  /// an instance of `type`.
  func parseEntry<T: Decodable>(
    _ pathString: String,
    _ type: T.Type
  ) throws -> T {
    let path = Path(pathString)
    let entryPath = path.isRoot ?
      path.components.joined(separator: "/") :
      pathString

    guard let entry = archive[entryPath] else {
      throw CoreXLSXError.archiveEntryNotFound
    }

    var data = Data()
    _ = try archive.extract(entry, bufferSize: bufferSize) {
      data += $0
    }

    return try decoder.decode(type, from: data)
  }

  public func parseRelationships() throws -> Relationships {
    decoder.keyDecodingStrategy = .convertFromCapitalized

    return try parseEntry("_rels/.rels", Relationships.self)
  }

  /// Return an array of paths to relationships of type `officeDocument`
  public func parseDocumentPaths() throws -> [String] {
    return try parseRelationships().items
      .filter { $0.type == .officeDocument }
      .map { $0.target }
  }

  public func parseStyles() throws -> Styles {
    decoder.keyDecodingStrategy = .useDefaultKeys

    return try parseEntry("xl/styles.xml", Styles.self)
  }

  public func parseSharedStrings() throws -> SharedStrings {
    decoder.keyDecodingStrategy = .useDefaultKeys

    return try parseEntry("xl/sharedStrings.xml", SharedStrings.self)
  }

  private func buildCommentsPath(forWorksheet path: String) throws -> String {
    let pattern = "xl\\/worksheets\\/sheet(\\d+)[.]xml"
    let regex = try NSRegularExpression(pattern: pattern, options: [])
    let range = NSRange(location: 0, length: path.utf16.count)

    if let match = regex.firstMatch(in: path, options: [], range: range),
      let worksheetIdRange = Range(match.range(at: 1), in: path) {
      let worksheetId = path[worksheetIdRange]
      return "xl/comments\(worksheetId).xml"
    }

    throw CoreXLSXError.unsupportedWorksheetPath
  }

  public func parseComments(forWorksheet path: String) throws -> Comments {
    let commentsPath = try buildCommentsPath(forWorksheet: path)

    decoder.keyDecodingStrategy = .useDefaultKeys

    return try parseEntry(commentsPath, Comments.self)
  }

  public func parseWorkbooks() throws -> [Workbook] {
    let paths = try parseDocumentPaths()

    decoder.keyDecodingStrategy = .useDefaultKeys

    return try paths.map {
      try parseEntry($0, Workbook.self)
    }
  }

  /** Return pairs of parsed document paths with corresponding relationships.

   **Deprecation warning**: this function doesn't handle root paths correctly,
   even though some XLSX files do contain root paths instead of relative
   paths. Use `parseDocumentRelationships(path:)` instead.
   */
  @available(*, deprecated, renamed: "parseDocumentRelationships(path:)")
  public func parseDocumentRelationships() throws
    -> [([Substring], Relationships)] {
    decoder.keyDecodingStrategy = .convertFromCapitalized

    return try parseDocumentPaths()
      .compactMap { path -> ([Substring], Relationships)? in
        let originalComponents = path.split(separator: "/")
        var components = originalComponents

        components.insert("_rels", at: 1)
        guard let filename = components.last else { return nil }
        components[components.count - 1] =
          Substring(filename.appending(".rels"))

        let relationships = try parseEntry(
          components.joined(separator: "/"),
          Relationships.self
        )
        return (originalComponents, relationships)
      }
  }

  /// Return parsed path with a parsed relationships model for a document at
  /// given path. Use `parseDocumentPaths` first to get a string path to pass
  /// as an argument to this function.
  public func parseDocumentRelationships(path: String) throws
    -> (Path, Relationships) {
    decoder.keyDecodingStrategy = .convertFromCapitalized

    let originalPath = Path(path)
    var components = originalPath.components

    components.insert("_rels", at: 1)
    guard let filename = components.last else { fatalError() }
    components[components.count - 1] =
      Substring(filename.appending(".rels"))

    let relationships = try parseEntry(
      components.joined(separator: "/"),
      Relationships.self
    )
    return (originalPath, relationships)
  }

  /// Parse and return an array of worksheets in this XLSX file.
  public func parseWorksheetPaths() throws -> [String] {
    return try parseDocumentPaths().map {
      try parseDocumentRelationships(path: $0)
    }.flatMap { (path, relationships) -> [String] in
      let worksheets = relationships.items.filter { $0.type == .worksheet }

      guard !path.isRoot else { return worksheets.map { $0.target } }

      // .rels file has paths relative to its directory,
      // storing that path in `pathPrefix`
      let pathPrefix = path.components.dropLast().joined(separator: "/")

      return worksheets.map { "\(pathPrefix)/\($0.target)" }
    }
  }

  /// Parse a worksheet at a given path contained in this XLSX file.
  public func parseWorksheet(at path: String) throws -> Worksheet {
    decoder.keyDecodingStrategy = .useDefaultKeys

    return try parseEntry(path, Worksheet.self)
  }

  /// Return all cells that are contained in a given worksheet and set of rows.
  @available(*, deprecated, renamed: "Worksheet.cells(atRows:)")
  public func cellsInWorksheet(at path: String, rows: [Int]) throws
    -> [Cell] {
    let ws = try parseWorksheet(at: path)

    return ws.data?.rows.filter { rows.contains(Int($0.reference)) }
      .reduce([]) { $0 + $1.cells } ?? []
  }

  /// Return all cells that are contained in a given worksheet and set of
  /// columns. This overloaded version is deprecated, you should pass
  /// an array of `ColumnReference` values as `columns` instead of an array
  /// of `String`s.
  @available(*, deprecated, renamed: "Worksheet.cells(atColumns:)")
  public func cellsInWorksheet(at path: String, columns: [String]) throws
    -> [Cell] {
    let ws = try parseWorksheet(at: path)

    return ws.data?.rows.map {
      let rowReference = $0.reference
      let targetReferences = columns
        .compactMap { (c: String) -> CellReference? in
          guard let columnReference = ColumnReference(c) else { return nil }
          return CellReference(columnReference, rowReference)
        }
      return $0.cells.filter { targetReferences.contains($0.reference) }
    }
    .reduce([]) { $0 + $1 } ?? []
  }
}
