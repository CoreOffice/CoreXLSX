//
//  CorePPTTests.swift
//  CorePPTTests
//
//  Created by Max Desiatov on 09/05/2019.
//

@testable import CorePPT
import XCTest

let currentWorkingPath = ProcessInfo.processInfo.environment["PPT_TESTS_PATH"]!

class CorePPTTests: XCTestCase {
  func testPublicAPI() throws {
    guard let file =
      PPTXFile(filepath: "\(currentWorkingPath)/sample.pptx") else {
      XCTAssert(false, "failed to open the file")
      return
    }

    let presentation = try file.parsePresentation()
    XCTAssertEqual(
      presentation.defaultTextStyle?.level2List?.leftMargin,
      457_200
    )
  }
}
