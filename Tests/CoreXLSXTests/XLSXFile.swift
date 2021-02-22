//
//  CoreXLSX.swift
//  CoreXLSXTests
//
//  Created by Max Desiatov on 27/10/2018.
//

@testable import CoreXLSX
import Foundation
import XCTest

let fixturesPath = URL(fileURLWithPath: #file)
  .deletingLastPathComponent()
  .appendingPathComponent("Fixtures")
  .path

final class CoreXLSXTests: XCTestCase {
  private let sheetPath = "xl/worksheets/sheet1.xml"

  func testBlank() throws {
    guard let file = XLSXFile(filepath: "\(fixturesPath)/Blank.xlsx")
    else {
      XCTFail("failed to open the file")
      return
    }

    let styles = try file.parseStyles()

    XCTAssertEqual(styles.borders?.count, 1)
    XCTAssertEqual(styles.borders?.items.count, 1)

    let ws = try file.parseWorksheet(at: "xl/worksheets/sheet1.xml")
    XCTAssertEqual(ws.data?.rows.count, 0)
  }

  func testHelloWorld() throws {
    guard let file = XLSXFile(filepath: "\(fixturesPath)/HelloWorld.xlsx")
    else {
      XCTFail("failed to open the file")
      return
    }

    let styles = try file.parseStyles()

    XCTAssertEqual(styles.borders?.count, 1)
    XCTAssertEqual(styles.borders?.items.count, 1)

    let ws = try file.parseWorksheet(at: "xl/worksheets/sheet1.xml")
    XCTAssertEqual(ws.data?.rows.count, 1)

    let cell = ws.data?.rows.first?.cells.first
    XCTAssertEqual(cell?.font(in: styles)?.size, nil)
  }

  func testMultiline() throws {
    guard
      let file = XLSXFile(filepath: "\(fixturesPath)/multi-line.text.in.cell.xlsx"),
      let strings = try file.parseSharedStrings()
    else {
      XCTFail("failed to open the file and get access to its shared strings")
      return
    }

    XCTAssertEqual(strings.uniqueCount, 2)
    XCTAssertEqual(strings.items, [
      .init(text: "just a single line", richText: []),
      .init(
        text: """
        first line
        second line (separated by CTRL+ALT+ENTER on macOS)
        third line
        """,
        richText: []
      ),
    ])
  }

  func testDates() throws {
    guard let file = XLSXFile(filepath: "\(fixturesPath)/Dates.xlsx") else {
      XCTFail("failed to open the file")
      return
    }

    let dates = try file.parseWorksheetPaths()
      .flatMap { try file.parseWorksheet(at: $0).data?.rows ?? [] }
      .flatMap { $0.cells }
      .compactMap { $0.dateValue }

    XCTAssertEqual(dates, [
      DateComponents(
        calendar: referenceCalendar,
        timeZone: referenceTimeZone,
        year: 2019,
        month: 09,
        day: 10
      ).date,
      DateComponents(
        calendar: referenceCalendar,
        timeZone: referenceTimeZone,
        year: 2019,
        month: 10,
        day: 11
      ).date,
    ])
  }

  func testPublicAPI() throws {
    guard
      let file = XLSXFile(filepath: "\(fixturesPath)/categories.xlsx"),
      let strings = try file.parseSharedStrings()
    else {
      XCTFail("failed to open the file and get access to its shared strings")
      return
    }

    XCTAssertEqual(try file.parseDocumentPaths(), ["xl/workbook.xml"])
    XCTAssertEqual(try file.parseWorksheetPaths(), [sheetPath])

    let ws = try file.parseWorksheet(at: sheetPath)
    guard let sd = ws.data else {
      XCTFail("no sheet data available")
      return
    }
    let allCells = sd.rows
      .map { $0.cells }
      .reduce([]) { $0 + $1 }
    XCTAssertEqual(allCells.count, 90)

    let rowReferences = sd.rows.map { $0.reference }
    let cellsFromRows = ws.cells(atRows: rowReferences)
    XCTAssertEqual(allCells, cellsFromRows)

    let cellsInFirstRow = ws.cells(atRows: [1])
    XCTAssertEqual(cellsInFirstRow.count, 6)

    let firstColumn = ("A" as UnicodeScalar).value
    let lastColumn = ("F" as UnicodeScalar).value
    let columnReferences = (firstColumn ... lastColumn)
      .compactMap { UnicodeScalar($0) }
      .compactMap { ColumnReference(String($0)) }

    XCTAssertEqual(allCells, ws.cells(atColumns: columnReferences))

    let closedRange1 = ColumnReference("A")! ... ColumnReference("F")!
    XCTAssertEqual(allCells, ws.cells(atColumns: closedRange1))

    let closedRange2 = ColumnReference("A")! ... ColumnReference("C")!
    let rowsRange: ClosedRange<UInt> = 3 ... 10
    let cellsInRange = ws.cells(atColumns: closedRange2, rows: rowsRange)
    XCTAssertEqual(cellsInRange.count, closedRange2.count * rowsRange.count)

    XCTAssertEqual(strings.items.count, 18)
  }

  func testLegacyPublicAPI() throws {
    guard let file = XLSXFile(filepath: "\(fixturesPath)/categories.xlsx")
    else {
      XCTFail("failed to open the file")
      return
    }

    XCTAssertEqual(try file.parseDocumentPaths(), ["xl/workbook.xml"])
    XCTAssertEqual(try file.parseWorksheetPaths(), [sheetPath])

    let relationships = try file.parseDocumentRelationships()
    XCTAssertEqual(relationships.count, 1)

    let ws = try file.parseWorksheet(at: sheetPath)
    XCTAssertEqual(ws.cols, ws.columns)
    XCTAssertEqual(ws.sheetPr, ws.properties)
    XCTAssertEqual(ws.sheetFormatPr, ws.formatProperties)
    XCTAssertEqual(
      ws.sheetFormatPr.defaultColWidth,
      ws.formatProperties?.defaultColumnWidth
    )
    XCTAssertEqual(
      ws.sheetFormatPr.outlineLevelCol,
      ws.formatProperties?.outlineLevelColumn
    )
    XCTAssertEqual(ws.dimension?.ref, ws.dimension?.reference)

    guard let mcs = ws.mergeCells else {
      XCTFail("expected to parse merge cells from categories.xlsx")
      return
    }
    for mc in mcs.items {
      XCTAssertEqual(mc.reference, mc.ref)
    }

    let allCells = ws.sheetData.rows
      .map { $0.cells }
      .reduce([]) { $0 + $1 }
    XCTAssertEqual(allCells.count, 90)

    for r in ws.sheetData.rows {
      XCTAssertEqual(r.height?.description, r.ht)
    }

    let rowReferences = ws.sheetData.rows.map { Int($0.reference) }
    let cellsFromRows = try file.cellsInWorksheet(at: sheetPath,
                                                  rows: rowReferences)
    XCTAssertEqual(allCells, cellsFromRows)

    let cellsInFirstRow = try file.cellsInWorksheet(at: sheetPath, rows: [1])
    XCTAssertEqual(cellsInFirstRow.count, 6)

    let firstColumn = ("A" as UnicodeScalar).value
    let lastColumn = ("F" as UnicodeScalar).value
    let columnReferences = (firstColumn ... lastColumn)
      .compactMap { UnicodeScalar($0) }.map { String($0) }
    let cellsFromAllColumns =
      try file.cellsInWorksheet(at: sheetPath, columns: columnReferences)
    XCTAssertEqual(allCells, cellsFromAllColumns)
  }

  func testRootRelationships() throws {
    guard let file =
      XLSXFile(filepath: "\(fixturesPath)/root_relationships.xlsx")
    else {
      XCTFail("failed to open the file")
      return
    }

    XCTAssertEqual(try file.parseDocumentPaths(), ["xl/workbook.xml"])
    XCTAssertEqual(try file.parseWorksheetPaths(), ["/\(sheetPath)"])
  }
}
