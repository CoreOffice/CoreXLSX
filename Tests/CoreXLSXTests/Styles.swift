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
//  Created by Max Desiatov on 16/03/2019.
//

@testable import CoreXLSX
import XCTest
import XMLCoder

private let numberFormats = NumberFormats(
  items: [
    NumberFormat(
      id: 0,
      formatCode: "General"
    ),
  ], count: 1
)

private let fonts = Fonts(
  items: [
    Font(
      size: Font.Size(value: 10),
      color: Color(indexed: 8, auto: nil, rgb: nil),
      name: Font.Name(value: "Helvetica Neue"),
      bold: nil,
      italic: nil,
      strike: nil
    ),
    Font(
      size: Font.Size(value: 12),
      color: Color(indexed: 8, auto: nil, rgb: nil),
      name: Font.Name(value: "Helvetica Neue"),
      bold: nil,
      italic: nil,
      strike: nil
    ),
    Font(
      size: Font.Size(value: 10),
      color: Color(indexed: 8, auto: nil, rgb: nil),
      name: Font.Name(value: "Helvetica Neue"),
      bold: Font.Bold(value: true),
      italic: nil,
      strike: nil
    ),
  ], count: 3
)

private let fills = Fills(items: [
  Fill(patternFill: PatternFill(
    patternType: "none",
    foregroundColor: nil,
    backgroundColor: nil
  )),
  Fill(patternFill: PatternFill(
    patternType: "gray125",
    foregroundColor: nil,
    backgroundColor: nil
  )),
  Fill(patternFill: PatternFill(
    patternType: "solid",
    foregroundColor: Color(indexed: 9, auto: nil, rgb: nil),
    backgroundColor: Color(indexed: nil, auto: 1, rgb: nil)
  )),
  Fill(patternFill: PatternFill(
    patternType: "solid",
    foregroundColor: Color(indexed: 11, auto: nil, rgb: nil),
    backgroundColor: Color(indexed: nil, auto: 1, rgb: nil)
  )),
  Fill(patternFill: PatternFill(
    patternType: "solid",
    foregroundColor: Color(indexed: 13, auto: nil, rgb: nil),
    backgroundColor: Color(indexed: nil, auto: 1, rgb: nil)
  )),
], count: 5)

final class StylesTests: XCTestCase {
  func testStyles() throws {
    guard let file =
      XLSXFile(filepath: "\(fixturesPath)/categories.xlsx")
    else {
      XCTFail("failed to open the file")
      return
    }

    let styles = try file.parseStyles()

    XCTAssertEqual(styles.numberFormats!, numberFormats)
    XCTAssertEqual(styles.fills!, fills)
    XCTAssertEqual(styles.fonts!, fonts)
    XCTAssertEqual(styles.borders!.count, 13)
    XCTAssertEqual(styles.cellStyleFormats!.count, 1)
    XCTAssertEqual(styles.cellFormats!.count, 28)
    XCTAssertEqual(styles.cellStyles!.count, 1)
    XCTAssertEqual(styles.differentialFormats!.count, 0)
    XCTAssertEqual(styles.tableStyles!.count, 0)
    XCTAssertEqual(styles.colors!.indexed.rgbColors.count, 14)

    let ws = try file.parseWorksheet(at: file.parseWorksheetPaths()[0])
    guard let sd = ws.data else {
      XCTFail("no sheet data available")
      return
    }

    XCTAssertEqual(sd.rows.first?.cells.first?.font(in: styles)?.size?.value, 12)
    XCTAssertEqual(sd.rows.last?.cells.first?.font(in: styles)?.size?.value, 10)
  }
}
