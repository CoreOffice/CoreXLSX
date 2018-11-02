import XCTest
@testable import CoreXLSX

final class XLSXReaderTests: XCTestCase {
  func testExample() {
    let currentWorkingPath = ProcessInfo.processInfo.environment["TESTS_PATH"]!

    do {
      let file = XLSXFile(filepath: "\(currentWorkingPath)/categories.xlsx")
      let sheetPath = "xl/worksheets/sheet1.xml"

      XCTAssertEqual(try file?.parseDocumentPaths(), ["xl/workbook.xml"])
      XCTAssertEqual(try file?.parseWorksheetPaths(), [sheetPath])
      let ws = try file?.parseWorksheet(at: sheetPath)
      let totalCellCount = ws?.sheetData.rows
        .map { $0.cells.count }
        .reduce(0, { $0 + $1 })
      XCTAssertEqual(totalCellCount, 90)
    } catch {
      XCTAssert(false, "unexpected error \(error)")
    }
  }

  static var allTests = [
    ("testExample", testExample),
  ]
}
