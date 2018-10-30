import XCTest
@testable import CoreXLSX

final class XLSXReaderTests: XCTestCase {
  func testExample() {
    let currentWorkingPath = ProcessInfo.processInfo.environment["TESTS_PATH"]!

    do {
      let file = XLSXFile(filepath: "\(currentWorkingPath)/categories.xlsx")

      XCTAssertEqual(try file?.parseDocumentPaths(), ["xl/workbook.xml"])
      XCTAssertEqual(try file?.parseWorksheetPaths(), ["worksheets/sheet1.xml"])
    } catch {
      XCTAssert(false, "unexpected error \(error)")
    }
  }

  static var allTests = [
    ("testExample", testExample),
  ]
}
