//
//  Reference.swift
//  CoreXLSX
//
//  Created by Max Desiatov on 13/11/2018.
//

import Foundation

public struct ColumnReference {
  public let value: String

  let intValue: Int

  init?(_ value: Int) {
    guard value > 0 else { return nil }

    intValue = value

    // log(1) == 0, working around that
    let symbolsCount = value == 1 ? 1 : Int(ceil(log(Double(value)) /
        log(Double(ColumnReference.alphabetLength))))

    var power = 1
    var value = value
    func symbolValue(i: Int) -> Int? {
      let nextPower = power * ColumnReference.alphabetLength
      let result = value % nextPower / power
      power = nextPower
      guard result == 0 else {
        return result
      }

      value -= power
      guard value >= 0 else {
        return nil
      }

      return ColumnReference.alphabetLength
    }

    func reducer(acc: String, i: Int) -> String {
      return String(Character(UnicodeScalar(
        ColumnReference.firstAllowedCharacter.value - 1 + UInt32(i)
      )!)) + acc
    }

    let result = (0..<symbolsCount).compactMap(symbolValue).reduce("", reducer)

    self.value = result
  }

  public init?(_ value: String) {
    self.init(Substring(value))
  }

  public init?(_ value: Substring) {
    guard !value.isEmpty else {
      return nil
    }

    let result = value.uppercased()

    guard result.unicodeScalars.allSatisfy({
      ColumnReference.allowedCharacters.contains($0)
    }) else { return nil }

    self.value = result

    // store unicode scalars in array to allow indexing with integers
    let scalars = Array(result.unicodeScalars)
    let count = result.unicodeScalars.count

    // pow(alphabetLength, $0) value where $0 is a given position,
    // it can be quickly calculated by multiplying previous value of `power`
    // from a previous iteration
    var power = 1

    intValue = (0..<count).map {
      // integer value for a symbol at a given position
      let symbolValue = Int(scalars[count - $0 - 1].value -
        ColumnReference.firstAllowedCharacter.value + 1)

      // total value calculated by multiplying symbolValue by the current
      // position value (which is `power`)
      let result = power * symbolValue
      power *= ColumnReference.alphabetLength
      return result
    }
    // sum all values
    .reduce(0, +)
  }

  static let firstAllowedCharacter = "A" as UnicodeScalar
  static let lastAllowedCharacter = "Z" as UnicodeScalar
  static let alphabetLength =
    Int(lastAllowedCharacter.value - firstAllowedCharacter.value + 1)

  static let allowedCharacters =
    CharacterSet(charactersIn: firstAllowedCharacter...lastAllowedCharacter)
}

extension ColumnReference: CustomStringConvertible {
  public var description: String {
    return "\(value)"
  }
}

extension ColumnReference: Comparable {
  public static func <(lhs: ColumnReference, rhs: ColumnReference) -> Bool {
    return lhs.value < rhs.value
  }

  public static func ==(lhs: ColumnReference, rhs: ColumnReference) -> Bool {
    return lhs.value == rhs.value
  }
}

extension ColumnReference: Strideable {
  public func distance(to target: ColumnReference) -> Int {
    return target.intValue - intValue
  }

  public func advanced(by offset: Int) -> ColumnReference {
    let targetIntValue = intValue + offset
    guard targetIntValue > 0 else { return ColumnReference("A")! }
    return ColumnReference(targetIntValue)!
  }
}
