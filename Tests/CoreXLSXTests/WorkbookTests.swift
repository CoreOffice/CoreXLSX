//
//  WorkbookTests.swift
//  CoreXLSXmacOS
//
//  Created by Max Desiatov on 23/11/2018.
//

import XCTest
@testable import CoreXLSX

private let parsed = [
  Workbook.Sheet(name: "Sheet 1",
                 id: "1",
                 relationship: "rId4")
]

final class WorkbookTests: XCTestCase {
  func testWorkbook() {
    guard let file =
      XLSXFile(filepath: "\(currentWorkingPath)/categories.xlsx") else {
        XCTAssert(false, "failed to open the file")
        return
    }

    do {
      let wbs = try file.parseWorkbooks()
      XCTAssertEqual(wbs[0].sheets.items, parsed)
    } catch {
      XCTAssert(false, "unexpected error \(error)")
    }
  }

  static let allTests = [
    ("testWorkbook", testWorkbook),
  ]
}
