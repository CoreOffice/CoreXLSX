//
//  Workbook.swift
//  CoreXLSXTests
//
//  Created by Max Desiatov on 23/11/2018.
//

@testable import CoreXLSX
import XCTest

private let parsed = [
  Workbook.Sheet(name: "Sheet 1",
                 id: "1",
                 relationship: "rId4"),
]

final class WorkbookTests: XCTestCase {
  func testWorkbook() throws {
    guard let file =
      XLSXFile(filepath: "\(currentWorkingPath)/categories.xlsx") else {
      XCTAssert(false, "failed to open the file")
      return
    }

    let wbs = try file.parseWorkbooks()
    XCTAssertEqual(wbs[0].sheets.items, parsed)
  }

  static let allTests = [
    ("testWorkbook", testWorkbook),
  ]
}
