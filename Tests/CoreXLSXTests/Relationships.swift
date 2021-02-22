// Copyright 2019-2020 CoreOffice contributors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
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

<Relationship
Id="rId4"
Type="http://customschemas.google.com/relationships/workbookmetadata"
Target="xl/metadata.xml"/>

</Relationships>
""".data(using: .utf8)!

let personXML = """
<Relationships
xmlns="http://schemas.openxmlformats.org/package/2006/relationships">

<Relationship
Id="rId4"
Type="http://schemas.microsoft.com/office/2017/10/relationships/\
person"
Target="xl/workbook.xml"/>

</Relationships>
""".data(using: .utf8)!

private let parsedFaultyWorksheet = [
  CoreXLSX.Relationship(id: "rId3", type: CoreXLSX.Relationship.SchemaType.packageCoreProperties, target: "docProps/core.xml"),
  CoreXLSX.Relationship(id: "rId2", type: CoreXLSX.Relationship.SchemaType.webExtensionTaskPanes, target: "xl/webextensions/taskpanes.xml"),
  CoreXLSX.Relationship(id: "rId1", type: CoreXLSX.Relationship.SchemaType.officeDocument, target: "xl/workbook.xml"),
  CoreXLSX.Relationship(id: "rId4", type: CoreXLSX.Relationship.SchemaType.extendedProperties, target: "docProps/app.xml"),
]

private let parsed = [
  Relationship(id: "rId1",
               type: .packageCoreProperties,
               target: "docProps/core.xml"),
  Relationship(id: "rId2",
               type: .extendedProperties,
               target: "docProps/app.xml"),
  Relationship(id: "rId3",
               type: .officeDocument,
               target: "xl/workbook.xml"),
  Relationship(id: "rId4",
               type: .googleWorkbookMetadata,
               target: "xl/metadata.xml"),
]

private let person =
  Relationship(id: "rId4",
               type: .person,
               target: "xl/workbook.xml")

final class RelationshipsTests: XCTestCase {
  func testRelationshipsXML() throws {
    let decoder = XMLDecoder()
    decoder.keyDecodingStrategy = .convertFromCapitalized
    let relationships = try decoder.decode(Relationships.self,
                                           from: exampleXML)
    XCTAssertEqual(relationships.items, parsed)
  }

  func testRelationshipsFromFile() throws {
    guard let file =
      XLSXFile(filepath: "\(fixturesPath)/categories.xlsx")
    else {
      XCTFail("failed to open the file")
      return
    }

    let relationshipsFromFile = try file.parseRelationships()

    XCTAssertEqual(relationshipsFromFile, Relationships(items: parsed.dropLast()))
  }

  func testRelationshipsFaultyWorksheet() throws {
    guard let file =
      XLSXFile(filepath: "\(fixturesPath)/faulty_worksheet.xlsx")
    else {
      XCTFail("failed to open the file")
      return
    }

    let relationshipsFromFile = try file.parseRelationships()

    XCTAssertEqual(relationshipsFromFile, Relationships(items: parsedFaultyWorksheet))
  }

  func testPersonRelationship() throws {
    let decoder = XMLDecoder()
    decoder.keyDecodingStrategy = .convertFromCapitalized
    let relationships = try decoder.decode(Relationships.self,
                                           from: personXML)
    XCTAssertEqual(relationships.items, [person])
  }

  func testCustomXmlSchemaType() throws {
    guard let file =
      XLSXFile(filepath: "\(fixturesPath)/jewelershealthcare.com-census.1.xlsx")
    else {
      XCTFail("failed to open the file")
      return
    }

    let relationshipsFromFile = try file.parseRelationships()

    let expected = Relationships(items: [
      Relationship(id: "rId3", type: .extendedProperties, target: "docProps/app.xml"),
      Relationship(id: "rId2", type: .packageCoreProperties, target: "docProps/core.xml"),
      Relationship(id: "rId1", type: .officeDocument, target: "xl/workbook.xml"),
      Relationship(id: "rId4", type: .customProperties, target: "docProps/custom.xml"),
    ])

    XCTAssertEqual(relationshipsFromFile, expected)

    let paths = try file.parseWorksheetPaths()
    XCTAssertEqual(paths, ["xl/worksheets/sheet1.xml"])
  }
}
