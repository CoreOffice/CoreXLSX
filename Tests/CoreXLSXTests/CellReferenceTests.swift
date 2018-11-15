//
//  CellReferenceTests.swift
//  CoreXLSXTests
//
//  Created by Max Desiatov on 15/11/2018.
//

import XCTest
import XMLCoder
@testable import CoreXLSX

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
  private let decoder = XMLDecoder()
  private let encoder = XMLEncoder()

  func testCellReference() {
    do {
      let c1 = try decoder.decode(Cell.self, from: exampleXML1)
      let cr1 = CellReference(ColumnReference("A")!, 7)
      XCTAssertEqual(cr1.description, "A7")
      XCTAssertEqual(c1,
                     Cell(reference: cr1,
                          type: nil, s: nil, inlineString: nil, formula: nil,
                          value: nil))

      let c2 = try decoder.decode(Cell.self, from: exampleXML2)
      let cr2 = CellReference(ColumnReference("ZA")!, 47)

      XCTAssertThrowsError(try decoder.decode(Cell.self, from: exampleXML3))

      XCTAssertEqual(cr2.description, "ZA47")
      XCTAssertEqual(c2,
                     Cell(reference: cr2,
                     type: nil, s: nil, inlineString: nil, formula: nil,
                     value: nil))

      let c1Encoded = try encoder.encode(c1, withRootKey: "Cell")
      XCTAssertEqual(c1, try decoder.decode(Cell.self, from: c1Encoded))

      let c2Encoded = try encoder.encode(c2, withRootKey: "Cell")
      XCTAssertEqual(c2, try decoder.decode(Cell.self, from: c2Encoded))

    } catch {
      XCTAssert(false, "unexpected error \(error)")
    }
  }

  func testColumnReference() {
    XCTAssertNil(ColumnReference(""))
    XCTAssertNil(ColumnReference("934875"))
    XCTAssertNil(ColumnReference("ø∫≈Ω"))
    XCTAssertEqual(ColumnReference("A"), ColumnReference("A"))
    XCTAssertNotEqual(ColumnReference("A"), ColumnReference("B"))

    guard let a = ColumnReference("A"), let b = ColumnReference("B") else {
      XCTAssert(false, "failed to create simple column references")
      return
    }

    XCTAssertTrue(a < b)
    XCTAssertFalse(b < a)
    XCTAssertFalse(a > b)
  }

  static let allTests = [
    ("testColumnReference", testColumnReference),
    ("testCellReference", testCellReference),
  ]
}
