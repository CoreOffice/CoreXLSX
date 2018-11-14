//
//  Reference.swift
//  CoreXLSX
//
//  Created by Max Desiatov on 13/11/2018.
//

import Foundation

struct ColumnReference {
  let value: String

  init(_ value: String) {
    self.value = value.uppercased()
  }

  static let allowedCharacters = CharacterSet.letters
}

extension ColumnReference: CustomStringConvertible {
  var description: String {
    return "\(value)"
  }
}

extension ColumnReference: Comparable {
  public static func < (lhs: ColumnReference, rhs: ColumnReference) -> Bool {
    return lhs.value < rhs.value
  }

  public static func == (lhs: ColumnReference, rhs: ColumnReference) -> Bool {
    return lhs.value == rhs.value
  }
}

extension ColumnReference: ExpressibleByStringLiteral {
  init(stringLiteral: String) {
    self.init(stringLiteral)
  }
}
