//
//  Comments.swift
//  CoreXLSXTests
//

@testable import CoreXLSX
import XCTest

final class CommentsTests: XCTestCase {
  func testComments() throws {
    guard let file =
      XLSXFile(filepath: "\(currentWorkingPath)/comments.xlsx") else {
      XCTAssert(false, "failed to open the file")
      return
    }
    let paths = try file.parseWorksheetPaths()
    let comments = try file.parseComments(forWorksheet: paths[0])
    XCTAssertEqual(comments.commentList.itemsByReference["A1"]?.text.plain,
                   "my note")
  }

  static let allTests = [
    ("testComments", testComments),
  ]
}
