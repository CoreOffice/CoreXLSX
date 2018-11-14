//
//  CellReference.swift
//  CoreXLSX
//
//  Created by Max Desiatov on 14/11/2018.
//

import Foundation

struct CellReference {
  let column: ColumnReference
  let row: Int

  init(_ column: ColumnReference, _ row: Int) {
    self.column = column
    self.row = row
  }
}

extension CellReference: CustomStringConvertible {
  var description: String {
    return "\(column)\(row)"
  }
}

extension CellReference: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let reference = try container.decode(String.self)

    guard let separatorIndex = reference.lastIndex(where: {
      $0.unicodeScalars.allSatisfy {
        ColumnReference.allowedCharacters.contains($0)
      }
    }) else { throw CoreXLSXError.invalidCellReference }

    let column = reference.prefix(upTo: separatorIndex)

    guard let cell = Int(reference.suffix(from: separatorIndex)) else {
      throw CoreXLSXError.invalidCellReference
    }

    self.init(ColumnReference(String(column)), cell)
  }
}

extension CellReference: Encodable {
  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(description)
  }
}
