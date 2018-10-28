import Foundation
import ZIPFoundation
import XMLParsing

public enum XLSXReaderError: Error {
  case relationshipsFileNotFound
}

public func sheets(filepath: String) throws -> [String] {
  let archiveURL = URL(fileURLWithPath: filepath)

  guard let archive = Archive(url: archiveURL, accessMode: .read),
  let entry = archive["_rels/.rels"]
  else {
    throw XLSXReaderError.relationshipsFileNotFound
  }

  var result: Relationships?
  _ = try archive.extract(entry) {
    result = try XMLDecoder().decode(Relationships.self, from: $0)
  }

  return result?.items.filter { $0.type == .officeDocument }
    .map { $0.target } ?? []
}
