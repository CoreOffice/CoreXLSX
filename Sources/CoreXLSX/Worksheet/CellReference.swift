//
//  CellReference.swift
//  CoreXLSX
//
//  Created by Max Desiatov on 14/11/2018.
//

public struct CellReference {
  public let column: ColumnReference
  public let row: UInt

  public init(_ column: ColumnReference, _ row: UInt) {
    self.column = column
    self.row = row
  }
}

extension CellReference: Equatable {
  public static func ==(lhs: CellReference, rhs: CellReference) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row
  }
}

extension CellReference: CustomStringConvertible {
  public var description: String {
    return "\(column)\(row)"
  }
}

extension CellReference: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let reference = try container.decode(String.self)

    guard let lastLetterIndex = reference.lastIndex(where: {
      $0.unicodeScalars.allSatisfy {
        ColumnReference.allowedCharacters.contains($0)
      }
    }) else {
      throw CoreXLSXError.invalidCellReference
    }

    let separatorIndex = reference.index(after: lastLetterIndex)

    guard let column =
      ColumnReference(reference.prefix(upTo: separatorIndex)) else {
      throw CoreXLSXError.invalidCellReference
    }

    guard let cell = UInt(reference.suffix(from: separatorIndex)) else {
      throw CoreXLSXError.invalidCellReference
    }

    self.init(column, cell)
  }
}

extension CellReference: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(description)
  }
}
