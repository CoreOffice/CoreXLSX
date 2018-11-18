//
//  Relationships.swift
//  CoreXLSX
//
//  Created by Max Desiatov on 27/10/2018.
//

struct Relationships: Codable {
  let items: [Relationship]

  enum CodingKeys: String, CodingKey {
    case items = "relationship"
  }
}

struct Relationship: Codable, Equatable {
  enum SchemaType: String, Codable {
    case officeDocument = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument"
    case extendedProperties = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties"
    case coreProperties = "http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties"
    case worksheet = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet"
    case sharedStrings = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/sharedStrings"
    case styles = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles"
    case theme = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme"
  }

  let id: String
  let type: SchemaType
  let target: String
}
