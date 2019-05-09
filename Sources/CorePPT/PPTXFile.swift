//
//  PPTXFile.swift
//  CorePPT
//
//  Created by Max Desiatov on 09/05/2019.
//

import Foundation
import XMLCoder
import ZIPFoundation

public enum CorePPTError: Error {
  case archiveEntryNotFound
}

public struct PPTXFile {
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
      throw CorePPTError.archiveEntryNotFound
    }

    var data = Data()
    _ = try archive.extract(entry, bufferSize: bufferSize) {
      data += $0
    }

    return try decoder.decode(type, from: data)
  }

  public func parsePresentation() throws -> Presentation {
    decoder.keyDecodingStrategy = .useDefaultKeys

    return try parseEntry("ppt/presentation.xml", Presentation.self)
  }
}
