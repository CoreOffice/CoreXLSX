//
//  CoreXLSX.swift
//  CoreXLSX
//
//  Created by Max Desiatov on 27/10/2018.
//

import Foundation
import ZIPFoundation
import XMLCoder

@available(*, deprecated, renamed: "CoreXLSXError")
public typealias XLSXReaderError = CoreXLSXError

public enum CoreXLSXError: Error {
  case archiveEntryNotFound
  case invalidCellReference
}

public struct XLSXFile {
  public let filepath: String
  private let archive: Archive
  private let decoder: XMLDecoder

  public init?(filepath: String) {
    let archiveURL = URL(fileURLWithPath: filepath)

    guard let archive = Archive(url: archiveURL, accessMode: .read) else {
      return nil
    }

    self.archive = archive
    self.filepath = filepath

    decoder = XMLDecoder()
  }

  /// Parse a file within `archive` at `path`. Parsing result is
  /// an instance of `type`.
  func parseEntry<T: Decodable>(_ path: String, _ type: T.Type) throws -> T {
    guard let entry = archive[path] else {
      throw CoreXLSXError.archiveEntryNotFound
    }

    var result: T?

    _ = try archive.extract(entry) {
      result = try decoder.decode(type, from: $0)
    }

    return result!
  }

  public func parseRelationships() throws -> Relationships {
    decoder.keyDecodingStrategy = .convertFromCapitalized

    return try parseEntry("_rels/.rels", Relationships.self)
  }

  /// Return an array of paths to relationships of type `officeDocument`
  func parseDocumentPaths() throws -> [String] {
    return try parseRelationships().items
      .filter { $0.type == .officeDocument }
      .map { $0.target }
  }

  public func parseSharedStrings() throws -> SharedStrings {
    decoder.keyDecodingStrategy = .useDefaultKeys

    return try parseEntry("xl/sharedStrings.xml", SharedStrings.self)
  }

  public func parseWorkbooks() throws -> [Workbook] {
    let paths = try parseDocumentPaths()

    decoder.keyDecodingStrategy = .useDefaultKeys

    return try paths.map {
      return try parseEntry($0, Workbook.self)
    }
  }

  /// Return pairs of parsed document paths with corresponding relationships
  public func parseDocumentRelationships() throws
  -> [([Substring], Relationships)] {
    decoder.keyDecodingStrategy = .convertFromCapitalized

    return try parseDocumentPaths().compactMap { path -> ([Substring], Relationships)? in
      let originalComponents = path.split(separator: "/")
      var components = originalComponents

      components.insert("_rels", at: 1)
      guard let filename = components.last else { return nil }
      components[components.count - 1] = Substring(filename.appending(".rels"))

      let relationships = try parseEntry(components.joined(separator: "/"),
                                         Relationships.self)
      return (originalComponents, relationships)
    }
  }

  /// Parse and return an array of worksheets in this XLSX file.
  public func parseWorksheetPaths() throws -> [String] {
    return try parseDocumentRelationships()
    .flatMap { (pathComponents, relationships) -> [String] in
      // .rels file has paths relative to its directory,
      // storing that path in `pathPrefix`
      let pathPrefix = pathComponents.dropLast().joined(separator: "/")

      return relationships.items.filter { $0.type == .worksheet }
        .map { "\(pathPrefix)/\($0.target)" }
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
      let targetReferences = columns.compactMap {
      (c: String) -> CellReference? in
        guard let columnReference = ColumnReference(c) else { return nil }
        return CellReference(columnReference, rowReference)
      }
      return $0.cells.filter { targetReferences.contains($0.reference) }
    }
    .reduce([]) { $0 + $1 } ?? []
  }
}
