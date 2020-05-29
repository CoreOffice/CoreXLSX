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

@testable import CoreXLSX
import XCTest
import XMLCoder

private let xml1 = """
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<worksheet
  xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main"
  xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
  xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" \
mc:Ignorable="x14ac"
  xmlns:x14ac="http://schemas.microsoft.com/office/spreadsheetml/2009/9/ac">
  <dimension ref="A1:E128"/>
  <sheetViews>
    <sheetView tabSelected="1" workbookViewId="0"/>
  </sheetViews>
  <sheetFormatPr
    defaultRowHeight="15"
    x14ac:dyDescent="0.25"/>
  <cols>
    <col min="1" max="1" width="26.42578125" customWidth="1"/>
    <col min="2" max="2" width="16.7109375" customWidth="1"/>
    <col min="3" max="3" width="9.140625" style="1"/>
    <col min="4" max="4" width="82" customWidth="1"/>
    <col min="6" max="6" width="16" customWidth="1"/>
  </cols>
  <sheetData>
    <row r="1" spans="1:5" s="2" customFormat="1" ht="15.75" thickBot="1" \
x14ac:dyDescent="0.3">
      <c r="A1" s="3" t="s"/>
    </row>
    <row r="2">
      <c r="E2">
      </c>
    </row>
    <row r="3" spans="1:5" x14ac:dyDescent="0.25">
      <c r="A3" t="s"/>
    </row><row r=
    "78" spans="1:5" x14ac:dyDescent="0.25">
      <c r="A78">
      </c>
    </row><row r=\r\n
"79" spans="1:5" x14ac:dyDescent="0.25">
      <c r="B79">
      </c>
    </row><row r=   "80" spans  =   "1:5" x14ac:dyDescent = "0.25">
      <c r="C80">
      </c>
    </row>
  </sheetData>
  <conditionalFormatting sqref="C56:C1048576 C1:C54">
    <cfRule type="duplicateValues" dxfId="2" priority="48"/>
  </conditionalFormatting>
  <conditionalFormatting sqref="C1:C1048576">
    <cfRule type="duplicateValues" dxfId="1" priority="1"/>
  </conditionalFormatting>
  <conditionalFormatting sqref="C2:C54">
    <cfRule type="duplicateValues" dxfId="0" priority="359"/>
  </conditionalFormatting>
  <pageMargins left="0.7" right="0.7" top="0.75" bottom="0.75" header="0.3" \
footer="0.3"/>
</worksheet>
""".data(using: .utf8)!

private let xml2 = """
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>

<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" \
xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" \
xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" \
mc:Ignorable="x14ac" \
xmlns:x14ac="http://schemas.microsoft.com/office/spreadsheetml/2009/9/ac">\
<dimension ref="A1:E128"/><sheetViews><sheetView tabSelected="1" \
workbookViewId="0"/></sheetViews><sheetFormatPr defaultRowHeight="15" \
x14ac:dyDescent="0.25"/><cols><col min="1" max="1" width="26.42578125" \
customWidth="1"/><col min="2" max="2" width="16.7109375" customWidth="1"/>\
<col min="3" max="3" width="9.140625" style="1"/><col min="4" max="4" \
width="82" customWidth="1"/><col min="6" max="6" width="16" customWidth="1"/>\
</cols><sheetData><row r=
    "78" spans="1:5" x14ac:dyDescent="0.25"><c r="A78" t="s"><v>3</v></c>\
<c r="B78" t="s"><v>4</v></c><c r="C78" s="1"><v>421</v></c><c r="D78" t="s">\
<v>56</v></c><c r="E78"><v>57</v></c></row></sheetData><conditionalFormatting \
sqref="C56:C1048576 C1:C54"><cfRule type="duplicateValues" dxfId="2" \
priority="48"/></conditionalFormatting><conditionalFormatting \
sqref="C1:C1048576"><cfRule type="duplicateValues" dxfId="1" priority="1"/>\
</conditionalFormatting><conditionalFormatting sqref="C2:C54"><cfRule \
type="duplicateValues" dxfId="0" priority="359"/></conditionalFormatting>\
<pageMargins left="0.7" right="0.7" top="0.75" bottom="0.75" header="0.3" \
footer="0.3"/></worksheet>
""".data(using: .utf8)!

private let parsed = [
  Column(
    min: 1,
    max: 1,
    width: 26.42578125,
    style: nil,
    customWidth: true
  ),
  Column(
    min: 2,
    max: 2,
    width: 16.7109375,
    style: nil,
    customWidth: true
  ),
  Column(
    min: 3,
    max: 3,
    width: 9.140625,
    style: 1,
    customWidth: nil
  ),
  Column(
    min: 4,
    max: 4,
    width: 82,
    style: nil,
    customWidth: true
  ),
  Column(
    min: 6,
    max: 6,
    width: 16,
    style: nil,
    customWidth: true
  ),
]

class WorksheetTests: XCTestCase {
  func testExample() throws {
    let decoder = XMLDecoder()

    let ws1 = try decoder.decode(Worksheet.self, from: xml1)
    XCTAssertEqual(
      ws1.formatProperties,
      Worksheet.FormatProperties(defaultRowHeight: "15")
    )
    XCTAssertEqual(ws1.columns?.items, parsed)
    XCTAssertEqual(ws1.cells(atRows: 1 ... 80).count, 6)

    let ws2 = try decoder.decode(Worksheet.self, from: xml2)
    XCTAssertEqual(ws2.cells(atRows: 1 ... 80).count, 5)
  }
}
