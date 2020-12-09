// Copyright 2019-2020 CoreOffice contributors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//  Created by Max Desiatov on 24/11/2018.
//

import Foundation

public extension Worksheet {
  /// Return all cells that are contained in a given worksheet and collection of
  /// columns.
  func cells<T>(atColumns columns: T) -> [Cell]
    where T: Collection, T.Element == ColumnReference
  {
    data?.rows.map {
      $0.cells.filter { columns.contains($0.reference.column) }
    }
    .reduce([]) { $0 + $1 } ?? []
  }

  /// Return all cells that are contained in a given worksheet and collection of
  /// rows.
  func cells<T>(atRows rows: T) -> [Cell]
    where T: Collection, T.Element == UInt
  {
    data?.rows.filter { rows.contains($0.reference) }
      .reduce([]) { $0 + $1.cells } ?? []
  }

  /// Return all cells that are contained in a given worksheet and collections
  /// of rows and columns.
  func cells<T1, T2>(atColumns columns: T1, rows: T2) -> [Cell]
    where T1: Collection, T1.Element == ColumnReference,
    T2: Collection, T2.Element == UInt
  {
    data?.rows.filter { rows.contains($0.reference) }.map {
      $0.cells.filter { columns.contains($0.reference.column) }
    }
    .reduce([]) { $0 + $1 } ?? []
  }
}

let referenceCalendar = Calendar(identifier: .gregorian)
let referenceTimeZone = TimeZone.autoupdatingCurrent
private let referenceDate = DateComponents(
  calendar: referenceCalendar,
  timeZone: referenceTimeZone,
  year: 1899,
  month: 12,
  day: 30,
  hour: 0,
  minute: 0,
  second: 0,
  nanosecond: 0
).date
private let secondsInADay: Double = 86400

public extension Cell {
  /// Returns a string value for this cell, potentially loading a shared string value from a
  /// given `sharedStrings` argument.
  func stringValue(_ sharedStrings: SharedStrings) -> String? {
    guard type == .sharedString, let index = value.flatMap(Int.init) else { return value }

    return sharedStrings.items[index].text
  }

  /// Returns a value of this cell as a RichText, from a given `sharedStrings` argument.
  func richStringValue(_ sharedStrings: SharedStrings) -> [RichText] {
    guard type == .sharedString, let index = value.flatMap(Int.init) else { return [] }

    return sharedStrings.items[index].richText
  }

  // swiftlint:disable line_length
  /// Returns a date value parsed from this cell in the [OLE Automation
  /// Date](https://docs.microsoft.com/en-us/dotnet/api/system.datetime.tooadate?view=netframework-4.8)
  /// format. As this format doesn't encode time zones, current user's time zone is used, which is
  /// taken from `TimeZone.autoupdatingCurrent`.
  var dateValue: Date? {
    // swiftlint:enable line_length
    guard
      type != .sharedString,
      let intervalSinceReference = value.flatMap(Double.init),
      let referenceDate = referenceDate
    else { return nil }

    let days = Int(floor(intervalSinceReference))
    let seconds = Int(
      round(intervalSinceReference.truncatingRemainder(dividingBy: 1) * secondsInADay)
    )

    guard let addedDays = referenceCalendar.date(byAdding: .day, value: days, to: referenceDate)
    else { return nil }

    return referenceCalendar.date(byAdding: .second, value: seconds, to: addedDays)
  }

  /// Returns a `Format` value applied to this cell, if any.
  func format(in styles: Styles) -> Format? {
    guard let styleIndex = styleIndex else { return nil }

    return styles.cellFormats?.items[styleIndex]
  }

  /// Returns a `Font` value applied to this cell, if any.
  func font(in styles: Styles) -> Font? {
    guard let fontID = format(in: styles)?.fontId else { return nil }

    return styles.fonts?.items[fontID]
  }
}
