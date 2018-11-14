//
//  Reference.swift
//  CoreXLSX
//
//  Created by Max Desiatov on 13/11/2018.
//

import Foundation

public struct ColumnReference {
  public let value: String

  public init?(_ value: String) {
    self.init(Substring(value))
  }

  public init?(_ value: Substring) {
    guard value.unicodeScalars.allSatisfy({
      ColumnReference.allowedCharacters.contains($0)
    }) else { return nil }

    self.value = value.uppercased()
  }

  static let allowedCharacters = CharacterSet.letters
}

extension ColumnReference: CustomStringConvertible {
  public var description: String {
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
