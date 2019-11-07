//
//  Relationships.swift
//  CoreXLSX
//
//  Created by Max Desiatov on 27/10/2018.
//

public struct Relationships: Codable, Equatable {
  public let items: [Relationship]

  enum CodingKeys: String, CodingKey {
    case items = "relationship"
  }
}

public struct Relationship: Codable, Equatable {
  public enum SchemaType: String, Codable {
    case calcChain =
      """
      http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
      calcChain
      """
    case officeDocument =
      """
      http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
      officeDocument
      """
    case extendedProperties =
      """
      http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
      extended-properties
      """
    case packageCoreProperties =
      """
      http://schemas.openxmlformats.org/package/2006/relationships/metadata/\
      core-properties
      """
    case coreProperties =
      """
      http://schemas.openxmlformats.org/officedocument/2006/relationships/\
      metadata/core-properties
      """
    case connections =
      """
      http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
      connections
      """
    case worksheet =
      """
      http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
      worksheet
      """
    case chartsheet =
      """
      http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
      chartsheet
      """
    case sharedStrings =
      """
      http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
      sharedStrings
      """
    case styles =
      """
      http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
      styles
      """
    case theme =
      """
      http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
      theme
      """
    case pivotCache =
      """
      http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
      pivotCacheDefinition
      """
    case metadataThumbnail =
      """
      http://schemas.openxmlformats.org/package/2006/relationships/metadata/\
      thumbnail
      """
    case customProperties =
      """
      http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
      custom-properties
      """
    case externalLink =
      """
      http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
      externalLink
      """
    case customXml =
      """
      http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
      customXml
      """
  }

  public let id: String
  public let type: SchemaType
  public let target: String
}
