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
//  Created by Max Desiatov on 02/05/2019.
//

@testable import CoreXLSX
import XCTest
import XMLCoder

private let formulaXML = """
<row r="11" spans="1:99" ht="13.15" customHeight="1">
  <c r="A11" s="42"/>
  <c r="B11" s="42"/>
  <c r="C11" s="42" t="s">
    <v>42</v>
  </c>
  <c r="D11" s="42"/>
  <c r="E11" s="42"/>
  <c r="F11" s="42">
    <f ca="1">NOW()</f>
    <v>42.42</v>
  </c>
  <c r="G11" s="363" t="s">
    <v>42</v>
  </c>
  <c r="H11" s="365"/>
  <c r="I11" s="96">
    <f ca="1">NOW()</f>
    <v>42.42</v>
  </c>
</row>
""".data(using: .utf8)!

final class FormulaTests: XCTestCase {
  func testFormulas() throws {
    let decoder = XMLDecoder()
    decoder.shouldProcessNamespaces = true

    let row = try decoder.decode(Row.self, from: formulaXML)
    XCTAssertEqual(row.cells.count, 9)
    XCTAssertEqual(row.cells[5].formula?.value, "NOW()")
    XCTAssertEqual(row.cells[8].formula?.value, "NOW()")
  }
}
