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
//  Created by Max Desiatov on 23/11/2018.
//

@testable import CoreXLSX
import XCTest
import XMLCoder

private let parsedSheet = [
  Workbook.Sheet(name: "Sheet 1",
                 id: "1",
                 relationship: "rId4"),
]

// swiftlint:disable line_length
private let workbookNoViews =
  """
  <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
  <workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:mx="http://schemas.microsoft.com/office/mac/excel/2008/main" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:mv="urn:schemas-microsoft-com:mac:vml" xmlns:x14="http://schemas.microsoft.com/office/spreadsheetml/2009/9/main" xmlns:x15="http://schemas.microsoft.com/office/spreadsheetml/2010/11/main" xmlns:x14ac="http://schemas.microsoft.com/office/spreadsheetml/2009/9/ac" xmlns:xm="http://schemas.microsoft.com/office/excel/2006/main"><workbookPr/><sheets><sheet state="visible" name="Summary" sheetId="1" r:id="rId4"/><sheet state="visible" name="General" sheetId="2" r:id="rId5"/></sheets><definedNames/><calcPr/></workbook>
  """.data(using: .utf8)!
// swiftlint:enable line_length

private let expectedWorkbook =
  Workbook(views: nil, sheets: .init(items: [
    .init(
      name: "Summary",
      id: "1",
      relationship: "rId4"
    ),
    .init(
      name: "General",
      id: "2",
      relationship: "rId5"
    ),
  ]))

final class WorkbookTests: XCTestCase {
  func testWorkbook() throws {
    guard let file =
      XLSXFile(filepath: "\(fixturesPath)/categories.xlsx")
    else {
      XCTFail("failed to open the file")
      return
    }

    let wbs = try file.parseWorkbooks()
    XCTAssertEqual(wbs[0].sheets.items, parsedSheet)
  }

  func testWorksheetPathsAndNames() throws {
    guard let file =
      XLSXFile(filepath: "\(fixturesPath)/categories.xlsx")
    else {
      XCTFail("failed to open the file")
      return
    }

    let wbs = try file.parseWorkbooks()
    let sheets = try file.parseWorksheetPathsAndNames(workbook: wbs[0])
    XCTAssertEqual(sheets.map { $0.name }, ["Sheet 1"])
  }

  func testWorkbookNoViews() throws {
    let decoder = XMLDecoder()
    decoder.shouldProcessNamespaces = true

    let decoded = try decoder.decode(Workbook.self, from: workbookNoViews)

    XCTAssertEqual(decoded, expectedWorkbook)
  }
}
