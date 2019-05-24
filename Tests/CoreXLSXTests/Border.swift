//
//  Border.swift
//  CoreXLSXTests
//
//  Created by Max Desiatov on 24/05/2019.
//

import CoreXLSX
import XCTest
@testable import XMLCoder

private let xml = """
<borders count="1">
<border/>
</borders>
""".data(using: .utf8)!

final class BorderTest: XCTestCase {
  func testSingleEmpty() throws {
    let result = try XMLDecoder().decode(Borders.self, from: xml)
    XCTAssertEqual(result.count, 1)
    XCTAssertEqual(result.items[0], nil)
  }
}
