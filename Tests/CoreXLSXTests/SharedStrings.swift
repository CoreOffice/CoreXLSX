//
//  SharedStrings.swift
//  CoreXLSXTests
//
//  Created by Max Desiatov on 30/11/2018.
//

@testable import CoreXLSX
import XCTest
import XMLCoder

private let parsed = SharedStrings(uniqueCount: 18, items: [
  SharedStrings.Item(text: "Table 1", richText: nil),
  SharedStrings.Item(text: "Item", richText: nil),
  SharedStrings.Item(text: "Name", richText: nil),
  SharedStrings.Item(text: "Amount", richText: nil),
  SharedStrings.Item(text: "Name:", richText: nil),
  SharedStrings.Item(text: "Subtotal:", richText: nil),
  SharedStrings.Item(text: "Andy", richText: nil),
  SharedStrings.Item(text: "Item 1", richText: nil),
  SharedStrings.Item(text: "Item 2", richText: nil),
  SharedStrings.Item(text: "Item 3", richText: nil),
  SharedStrings.Item(text: "Item 4", richText: nil),
  SharedStrings.Item(text: "Item 5", richText: nil),
  SharedStrings.Item(text: "Chloe", richText: nil),
  SharedStrings.Item(text: "Item 6", richText: nil),
  SharedStrings.Item(text: "Item 7", richText: nil),
  SharedStrings.Item(text: "Item 8", richText: nil),
  SharedStrings.Item(text: "Item 9", richText: nil),
  SharedStrings.Item(text: "Item 10", richText: nil),
  ])

private let columnC = ["Name", "Andy", "Andy", "Andy", "Andy", "Andy",
                       "Chloe", "Chloe", "Chloe", "Chloe", "Chloe"]

final class SharedStringsTests: XCTestCase {
  func testSharedStrings() throws {
    guard let file =
      XLSXFile(filepath: "\(currentWorkingPath)/categories.xlsx") else {
        XCTAssert(false, "failed to open the file")
        return
    }
    
    let sharedStrings = try file.parseSharedStrings()
    
    // check each individual item so that it's easier to debug when something
    // goes wrong
    for (i, item) in sharedStrings.items.enumerated() {
      XCTAssertEqual(item, parsed.items[i])
    }
    
    // check the complete value anyway to make sure all properties are equal
    XCTAssertEqual(sharedStrings, parsed)
  }
  
  func testSharedStringsOrder() throws {
    guard let file =
      XLSXFile(filepath: "\(currentWorkingPath)/categories.xlsx") else {
        XCTAssert(false, "failed to open the file")
        return
    }
    
    let sharedStrings = try file.parseSharedStrings()
    
    var columnCStrings: [String] = []
    
    for path in try file.parseWorksheetPaths() {
      let ws = try file.parseWorksheet(at: path)
      for row in ws.data?.rows ?? [] {
        for c in row.cells {
          if c.type == "s" && c.reference.column.intValue == 3,
            let value = c.value.flatMap({ Int($0) }),
            let string = sharedStrings.items[value].text.flatMap({ String($0) }) {
            columnCStrings.append(string)
          }
        }
      }
    }
    
    XCTAssertEqual(columnC, columnCStrings)
  }
  
  static let allTests = [
    ("testSharedStrings", testSharedStrings),
    ("testSharedStringsOrder", testSharedStringsOrder),
    ]
}
