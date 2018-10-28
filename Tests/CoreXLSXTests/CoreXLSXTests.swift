import XCTest
@testable import CoreXLSX

final class XLSXReaderTests: XCTestCase {
  func testExample() {
    let currentWorkingPath = ProcessInfo.processInfo.environment["TESTS_PATH"]!

    do {
      let s = try sheets(filepath: "\(currentWorkingPath)/categories.xlsx")
      XCTAssertEqual(s, ["xl/workbook.xml"])
    } catch {
      XCTAssert(false, "unexpected error \(error)")
    }
  }

  static var allTests = [
    ("testExample", testExample),
  ]
}
