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
//  Created by Max Desiatov on 15/11/2018.
//

@testable import CoreXLSX
import XCTest
import XMLCoder

private let exampleXML1 = """
<Cell r="A7" />
""".data(using: .utf8)!

private let exampleXML2 = """
<Cell r="ZA47" />
""".data(using: .utf8)!

private let exampleXML3 = """
<Cell r="kljsndfkvljdsfnjkvl" />
""".data(using: .utf8)!

final class CellReferenceTests: XCTestCase {
  func testCellReference() throws {
    let decoder = XMLDecoder()
    let encoder = XMLEncoder()

    let c1 = try decoder.decode(Cell.self, from: exampleXML1)
    let cr1 = CellReference(ColumnReference("A")!, 7)
    XCTAssertEqual(cr1.description, "A7")
    XCTAssertEqual(
      c1,
      Cell(
        reference: cr1,
        type: nil, styleIndex: nil, inlineString: nil, formula: nil,
        value: nil
      )
    )

    let c2 = try decoder.decode(Cell.self, from: exampleXML2)
    let cr2 = CellReference(ColumnReference("ZA")!, 47)

    XCTAssertThrowsError(try decoder.decode(Cell.self, from: exampleXML3))

    XCTAssertEqual(cr2.description, "ZA47")
    XCTAssertEqual(
      c2,
      Cell(
        reference: cr2,
        type: nil, styleIndex: nil, inlineString: nil, formula: nil,
        value: nil
      )
    )

    let c1Encoded = try encoder.encode(c1, withRootKey: "Cell")
    XCTAssertEqual(c1, try decoder.decode(Cell.self, from: c1Encoded))

    let c2Encoded = try encoder.encode(c2, withRootKey: "Cell")
    XCTAssertEqual(c2, try decoder.decode(Cell.self, from: c2Encoded))
  }

  func testColumnReference() {
    XCTAssertNil(ColumnReference(""))
    XCTAssertNil(ColumnReference("934875"))
    XCTAssertNil(ColumnReference("ø∫≈Ω"))
    XCTAssertEqual(ColumnReference("A"), ColumnReference("A"))
    XCTAssertNotEqual(ColumnReference("A"), ColumnReference("B"))

    guard let a = ColumnReference("A"), let b = ColumnReference("B") else {
      XCTFail("failed to create simple column references")
      return
    }

    XCTAssertTrue(a < b)
    XCTAssertFalse(b < a)
    XCTAssertFalse(a > b)
  }

  func testColumnReferenceDistance() {
    guard let a = ColumnReference("A"), let z = ColumnReference("z"),
          let aa = ColumnReference("AA"), let az = ColumnReference("Az"),
          let ba = ColumnReference("ba"), let bz = ColumnReference("bz")
    else {
      XCTFail("failed to create simple column references")
      return
    }
    let alphabetLength = 26

    XCTAssertEqual(a.intValue, 1)
    XCTAssertEqual(z.intValue, alphabetLength)
    XCTAssertEqual(aa.intValue, alphabetLength + 1)
    XCTAssertEqual(az.intValue, alphabetLength * 2)
    XCTAssertEqual(ba.intValue, alphabetLength * 2 + 1)
    XCTAssertEqual((a ... z).count, alphabetLength)
    XCTAssertEqual((a ... az).count, alphabetLength * 2)
    XCTAssertEqual((a ... ba).count, alphabetLength * 2 + 1)
    XCTAssertEqual((az ... ba).count, 2)
    XCTAssertEqual((az ... bz).count, alphabetLength + 1)
  }

  func testColumnReferenceComparable() {
    guard let ab = ColumnReference("AB"), let b = ColumnReference("B")
    else {
      XCTFail("failed to create simple column references")
      return
    }

    XCTAssertGreaterThan(ab, b)
  }

  func testColumnReferenceIntInitializer() {
    guard let a = ColumnReference("A"), let z = ColumnReference("z"),
          let aa = ColumnReference("AA"), let az = ColumnReference("Az"),
          let ba = ColumnReference("ba"), let bz = ColumnReference("bz"),
          let abc = ColumnReference("abc"), let azz = ColumnReference("azz"),
          let zz = ColumnReference("zz"), let azza = ColumnReference("azza")
    else {
      XCTFail("failed to create simple column references")
      return
    }

    XCTAssertEqual(ColumnReference(a.intValue), a)
    XCTAssertEqual(ColumnReference(z.intValue), z)
    XCTAssertEqual(ColumnReference(az.intValue), az)
    XCTAssertEqual(ColumnReference(zz.intValue), zz)
    XCTAssertEqual(ColumnReference(aa.intValue), aa)
    XCTAssertEqual(ColumnReference(ba.intValue), ba)
    XCTAssertEqual(ColumnReference(bz.intValue), bz)
    XCTAssertEqual(ColumnReference(abc.intValue), abc)
    XCTAssertEqual(ColumnReference(azz.intValue), azz)
    XCTAssertEqual(ColumnReference(azza.intValue), azza)
  }

  func testColumnReferenceStringInitializerPerformance() {
    measure {
      for _ in 0 ..< 10000 {
        _ = ColumnReference("kjhbjhblkjn")
      }
    }
  }

  func testColumnReferenceIntInitializerPerformance() {
    measure {
      for _ in 0 ..< 10000 {
        _ = ColumnReference(Int.max / 10)
      }
    }
  }

  func testColumnReferenceAdvancedBy() {
    guard let a = ColumnReference("A"), let bz = ColumnReference("bz") else {
      XCTFail("failed to create simple column references")
      return
    }

    XCTAssertEqual((a ... bz).reversed().reversed(), Array(a ... bz))
  }
}
