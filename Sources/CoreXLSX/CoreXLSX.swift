import Foundation
import ZIPFoundation
import XMLParsing

public enum XLSXReaderError: Error {
  case relationshipsFileNotFound
}

public func sheets(filepath: String) throws -> [String] {
  let archiveURL = URL(fileURLWithPath: filepath)

  guard let archive = Archive(url: archiveURL, accessMode: .read),
  let entry = archive["blah"]
  else {
    throw XLSXReaderError.relationshipsFileNotFound
  }

  try archive.extract(entry) {
    try? XMLDecoder().decode(Relationships.self, from: $0)
  }

  return []
}
