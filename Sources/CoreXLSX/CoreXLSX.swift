import Foundation
import ZIPFoundation
import XMLParsing

public enum XLSXReaderError: Error {
  case relationshipsFileNotFound
}

public struct XLSXFile {
  public let filepath: String
  private let archive: Archive
  private let decoder: XMLDecoder

  init?(filepath: String) {
    let archiveURL = URL(fileURLWithPath: filepath)

    guard let archive = Archive(url: archiveURL, accessMode: .read) else {
      return nil
    }

    self.archive = archive
    self.filepath = filepath

    decoder = XMLDecoder()
    decoder.keyDecodingStrategy = .convertFromCapitalized
  }

  func parseEntry<T: Decodable>(_ path: String, _ type: T.Type) throws -> T {
    guard let entry = archive[path] else {
      throw XLSXReaderError.relationshipsFileNotFound
    }

    var result: T?

    _ = try archive.extract(entry) {
      result = try decoder.decode(type, from: $0)
    }

    return result!
  }

  /// Return the list of paths to relationships of type `officeDocument`
  func parseDocumentPaths() throws -> [String] {
    return try parseEntry("_rels/.rels", Relationships.self).items
      .filter { $0.type == .officeDocument }
      .map { $0.target }
  }

  public func parseWorksheetPaths() throws -> [String] {
    return try parseDocumentPaths().flatMap { (path: String) -> [String] in
      var components = path.split(separator: "/")
      components.insert("_rels", at: 1)
      guard let filename = components.last else { return [] }
      components[components.count - 1] = Substring(filename.appending(".rels"))

      return
        try parseEntry(components.joined(separator: "/"), Relationships.self)
          .items.filter { $0.type == .worksheet }
          .map { $0.target }
    }
  }
}
