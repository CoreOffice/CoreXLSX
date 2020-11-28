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
//  Created by Max Desiatov on 12/06/2020.
//

@testable import CoreXLSX
import XCTest

final class CellQueriesTests: XCTestCase {
  // swiftlint:disable:next function_body_length
  func testDates() throws {
    let cells = [
      Cell(
        reference: CellReference(ColumnReference("I")!, 2),
        type: nil,
        styleIndex: 7,
        inlineString: nil,
        formula: nil,
        value: "0.39583333333212067"
      ),
      Cell(
        reference: CellReference(ColumnReference("J")!, 2),
        type: nil,
        styleIndex: 7,
        inlineString: nil,
        formula: nil,
        value: "0.54166666666787933"
      ),
      Cell(
        reference: CellReference(ColumnReference("K")!, 2),
        type: nil,
        styleIndex: 7,
        inlineString: nil,
        formula: nil,
        value: "0.625"
      ),
      Cell(
        reference: CellReference(ColumnReference("L")!, 2),
        type: nil,
        styleIndex: 7,
        inlineString: nil,
        formula: nil,
        value: "0.8125"
      ),
      Cell(
        reference: CellReference(ColumnReference("O")!, 2),
        type: nil,
        styleIndex: 7,
        inlineString: nil,
        formula: nil,
        value: "0.625"
      ),
      Cell(
        reference: CellReference(ColumnReference("P")!, 2),
        type: nil,
        styleIndex: 7,
        inlineString: nil,
        formula: nil,
        value: "0.75"
      ),
      Cell(
        reference: CellReference(ColumnReference("U")!, 2),
        type: nil,
        styleIndex: 7,
        inlineString: nil,
        formula: nil,
        value: "0.33333333333212067"
      ),
      Cell(
        reference: CellReference(ColumnReference("V")!, 2),
        type: nil,
        styleIndex: 7,
        inlineString: nil,
        formula: nil,
        value: "0.45833333333212067"
      ),
      Cell(
        reference: CellReference(ColumnReference("Y")!, 2),
        type: nil,
        styleIndex: 7,
        inlineString: nil,
        formula: nil,
        value: "0.33333333333212067"
      ),
      Cell(
        reference: CellReference(ColumnReference("Z")!, 2),
        type: nil,
        styleIndex: 7,
        inlineString: nil,
        formula: nil,
        value: "0.45833333333212067"
      ),
    ]

    XCTAssertEqual(
      cells.compactMap { $0.dateValue?.timeIntervalSince1970 },
      [-2_209_127_400.0, -2_209_114_800.0, -2_209_107_600.0, -2_209_091_400.0, -2_209_107_600.0,
       -2_209_096_800.0, -2_209_132_800.0, -2_209_122_000.0, -2_209_132_800.0, -2_209_122_000.0]
    )
  }
}
