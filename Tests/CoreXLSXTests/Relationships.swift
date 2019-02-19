//
//  Relationships.swift
//  CoreXLSXTests
//
//  Created by Max Desiatov on 15/11/2018.
//

@testable import CoreXLSX
import XCTest
import XMLCoder

private let exampleXML = """
<Relationships
xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
<Relationship
Id="rId1"
Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/\
core-properties"
Target="docProps/core.xml"/>

<Relationship
Id="rId2"
Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
extended-properties"
Target="docProps/app.xml"/>

<Relationship
Id="rId3"
Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
officeDocument"
Target="xl/workbook.xml"/>

</Relationships>
""".data(using: .utf8)!

private let parsed = [
  Relationship(id: "rId1",
               type: .coreProperties,
               target: "docProps/core.xml"),
  Relationship(id: "rId2",
               type: .extendedProperties,
               target: "docProps/app.xml"),
  Relationship(id: "rId3",
               type: .officeDocument,
               target: "xl/workbook.xml"),
]

final class RelationshipsTests: XCTestCase {
  private let decoder = XMLDecoder()

  override func setUp() {
    super.setUp()

    decoder.keyDecodingStrategy = .convertFromCapitalized
  }

  func testRelationships() throws {
    let relationships = try decoder.decode(Relationships.self,
                                           from: exampleXML)
    XCTAssertEqual(relationships.items, parsed)

    guard let file =
      XLSXFile(filepath: "\(currentWorkingPath)/categories.xlsx") else {
      XCTAssert(false, "failed to open the file")
      return
    }

    let relationshipsFromFile = try file.parseRelationships()

    XCTAssertEqual(relationshipsFromFile, Relationships(items: parsed))
  }

  static let allTests = [
    ("testRelationships", testRelationships),
  ]
}
