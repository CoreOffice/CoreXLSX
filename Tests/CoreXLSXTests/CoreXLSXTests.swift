import XCTest
@testable import CoreXLSX

final class XLSXReaderTests: XCTestCase {
  let currentWorkingPath = ProcessInfo.processInfo.environment["TESTS_PATH"]!
  let sheetPath = "xl/worksheets/sheet1.xml"

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

  func testPublicAPI() {
    do {
      guard let file =
        XLSXFile(filepath: "\(currentWorkingPath)/categories.xlsx") else {
          XCTAssert(false, "failed to open the file")
          return
      }

      XCTAssertEqual(try file.parseDocumentPaths(), ["xl/workbook.xml"])
      XCTAssertEqual(try file.parseWorksheetPaths(), [sheetPath])

      let ws = try file.parseWorksheet(at: sheetPath)
      let allCells = ws.sheetData.rows
        .map { $0.cells }
        .reduce([], { $0 + $1 })
      XCTAssertEqual(allCells.count, 90)

      let rowReferences = ws.sheetData.rows.map { $0.reference }
      let cellsFromRows = ws.cells(atRows: rowReferences)
      XCTAssertEqual(allCells, cellsFromRows)

      let cellsInFirstRow = ws.cells(atRows: [1])
      XCTAssertEqual(cellsInFirstRow.count, 6)

      let firstColumn = ("A" as UnicodeScalar).value
      let lastColumn = ("F" as UnicodeScalar).value
      let columnReferences = (firstColumn...lastColumn)
        .compactMap { UnicodeScalar($0) }
        .compactMap { ColumnReference(String($0)) }
      let cellsFromAllColumns = ws.cells(atColumns: columnReferences)
      XCTAssertEqual(allCells, cellsFromAllColumns)
    } catch {
      XCTAssert(false, "unexpected error \(error)")
    }
  }

  func testLegacyPublicAPI() {
    do {
      guard let file =
      XLSXFile(filepath: "\(currentWorkingPath)/categories.xlsx") else {
        XCTAssert(false, "failed to open the file")
        return
      }

      XCTAssertEqual(try file.parseDocumentPaths(), ["xl/workbook.xml"])
      XCTAssertEqual(try file.parseWorksheetPaths(), [sheetPath])

      let ws = try file.parseWorksheet(at: sheetPath)
      let allCells = ws.sheetData.rows
        .map { $0.cells }
        .reduce([], { $0 + $1 })
      XCTAssertEqual(allCells.count, 90)

      let rowReferences = ws.sheetData.rows.map { Int($0.reference) }
      let cellsFromRows = try file.cellsInWorksheet(at: sheetPath,
                                                    rows: rowReferences)
      XCTAssertEqual(allCells, cellsFromRows)

      let cellsInFirstRow = try file.cellsInWorksheet(at: sheetPath, rows: [1])
      XCTAssertEqual(cellsInFirstRow.count, 6)

      let firstColumn = ("A" as UnicodeScalar).value
      let lastColumn = ("F" as UnicodeScalar).value
      let columnReferences = (firstColumn...lastColumn)
        .compactMap { UnicodeScalar($0) }.map { String($0) }
      let cellsFromAllColumns =
        try file.cellsInWorksheet(at: sheetPath, columns: columnReferences)
      XCTAssertEqual(allCells, cellsFromAllColumns)
    } catch {
      XCTAssert(false, "unexpected error \(error)")
    }
  }

  static var allTests = [
    ("testColumnReference", testColumnReference),
    ("testPublicAPI", testPublicAPI),
    ("testLegacyPublicAPI", testLegacyPublicAPI),
  ]
}
