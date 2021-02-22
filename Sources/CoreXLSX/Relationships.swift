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
//  Created by Max Desiatov on 27/10/2018.
//

/** An array of `Relationship` values. This type directly maps the internal XML structure of the
 `.xlsx` format.
 */
public struct Relationships: Codable, Equatable {
  public let items: [Relationship]

  enum CodingKeys: String, CodingKey {
    case items = "relationship"
  }
}

/** Relationship to an entity stored in a given `.xlsx` archive. These can be worksheets,
 chartsheets, thumbnails and a few other internal entities. Most of the time users of CoreXLSX
 wouldn't need to handle relationships directly.
 */
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
      http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
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
    case person =
      """
      http://schemas.microsoft.com/office/2017/10/relationships/\
      person
      """
    case webExtensionTaskPanes =
      """
      http://schemas.microsoft.com/office/2011/relationships/\
      webextensiontaskpanes
      """
    case googleWorkbookMetadata =
      """
      http://customschemas.google.com/relationships/workbookmetadata
      """
    case purlOCLC =
      """
      http://purl.oclc.org/ooxml/officeDocument/relationships/extendedProperties
      """
  }

  /// The identifier for this entity.
  public let id: String

  /// The type of this entity.
  public let type: SchemaType

  /// The path to this entity in the `.xlsx` archive.
  public let target: String

  func path(from root: String) -> String {
    Path(target).isRoot ? target : "\(root)/\(target)"
  }
}
