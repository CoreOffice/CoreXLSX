//
//  Relationships.swift
//  XLSXReader
//
//  Created by Max Desiatov on 27/10/2018.
//

import Foundation

struct Relationships: Codable {
  let items: [Relationship]
}

struct Relationship: Codable {
  enum SchemaType: String, Codable {
    case officeDocument = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument"
    case extendedProperties = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties"
    case coreProperties = "http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties"
  }

  let id: String
  let type: SchemaType
  let target: String

}
