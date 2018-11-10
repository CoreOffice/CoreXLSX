import Foundation
import ZIPFoundation
import XMLCoder

public enum XLSXReaderError: Error {
  case archiveEntryNotFound
}

public struct XLSXFile {
  public let filepath: String
  private let archive: Archive
  private let decoder: XMLDecoder
  private let worksheetCache: [String: Worksheet]

  public init?(filepath: String) {
    let archiveURL = URL(fileURLWithPath: filepath)

    guard let archive = Archive(url: archiveURL, accessMode: .read) else {
      return nil
    }

    self.archive = archive
    self.filepath = filepath

    decoder = XMLDecoder()
  }

  func parseEntry<T: Decodable>(_ path: String, _ type: T.Type) throws -> T {
    guard let entry = archive[path] else {
      throw XLSXReaderError.archiveEntryNotFound
    }

    var result: T?

    _ = try archive.extract(entry) {
      result = try decoder.decode(type, from: $0)
    }

    return result!
  }

  /// Return the list of paths to relationships of type `officeDocument`
  func parseDocumentPaths() throws -> [String] {
    decoder.keyDecodingStrategy = .convertFromCapitalized

    return try parseEntry("_rels/.rels", Relationships.self).items
      .filter { $0.type == .officeDocument }
      .map { $0.target }
  }

  public func parseWorksheetPaths() throws -> [String] {
    decoder.keyDecodingStrategy = .convertFromCapitalized

    return try parseDocumentPaths().flatMap { (path: String) -> [String] in
      var components = path.split(separator: "/")

      // .rels file has paths relative to its directory,
      // storing that path in `pathPrefix`
      let pathPrefix = components.dropLast().joined(separator: "/")

      components.insert("_rels", at: 1)
      guard let filename = components.last else { return [] }
      components[components.count - 1] = Substring(filename.appending(".rels"))

      return
        try parseEntry(components.joined(separator: "/"), Relationships.self)
          .items.filter { $0.type == .worksheet }
          .map { "\(pathPrefix)/\($0.target)" }
    }
  }

  public func parseWorksheet(at path: String) throws -> Worksheet {
    decoder.keyDecodingStrategy = .useDefaultKeys

    guard let result = worksheetCache[path] else {
      return try parseEntry(path, Worksheet.self)
    }

    return result
  }

  public func cellsInWorksheet(at path: String, rows: [Int]) throws -> [Cell] {
    let ws = parseWorksheet(at: path)

    let references = rows.map { "\($0)" }
    return ws.sheetData.rows.filter { references.contains($0.reference) }
      .reduce([]) { $0 + $1 }
  }

  public func cellsInWorksheet(at path: String, columns: [String]) throws
  -> [Cell] {
    return []
  }
}
