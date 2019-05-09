//
//  Presentation.swift
//  CorePPT
//
//  Created by Max Desiatov on 09/05/2019.
//

/// http://www.datypic.com/sc/ooxml/t-a_CT_TextCharacterProperties.html
public struct TextParagraphProperties: Codable {
  public let defaultTextRun: TextCharacterProperties
  public let leftMargin: UInt64?

  enum CodingKeys: String, CodingKey {
    case defaultTextRun = "defRPr"
    case leftMargin = "marL"
  }
}

/// http://www.datypic.com/sc/ooxml/e-a_defRPr-1.html
public struct TextCharacterProperties: Codable {
  public let lang: String?
}

/// http://www.datypic.com/sc/ooxml/e-p_defaultTextStyle-1.html
public struct DefaultTextStyle: Codable {
  public let defaultParagraph: TextParagraphProperties?
  public let level1List: TextParagraphProperties?
  public let level2List: TextParagraphProperties?
  public let level3List: TextParagraphProperties?
  public let level4List: TextParagraphProperties?
  public let level5List: TextParagraphProperties?
  public let level6List: TextParagraphProperties?
  public let level7List: TextParagraphProperties?
  public let level8List: TextParagraphProperties?
  public let level9List: TextParagraphProperties?

  enum CodingKeys: String, CodingKey {
    case defaultParagraph = "defPPr"
    case level1List = "lvl1pPr"
    case level2List = "lvl2pPr"
    case level3List = "lvl3pPr"
    case level4List = "lvl4pPr"
    case level5List = "lvl5pPr"
    case level6List = "lvl6pPr"
    case level7List = "lvl7pPr"
    case level8List = "lvl8pPr"
    case level9List = "lvl9pPr"
  }
}

/// http://www.datypic.com/sc/ooxml/t-a_CT_PositiveSize2D.html
public struct Size: Codable {
  public let width: UInt64
  public let height: UInt64

  enum CodingKeys: String, CodingKey {
    case width = "cx"
    case height = "cy"
  }
}

public struct Presentation: Codable {
  public let saveSubsetFonts: Bool?
  public let autoCompressPictures: Bool?
  public let slideSize: Size?
  public let notesSize: Size?
  public let defaultTextStyle: DefaultTextStyle?

  enum CodingKeys: String, CodingKey {
    case saveSubsetFonts
    case autoCompressPictures
    case slideSize = "sldSz"
    case notesSize = "notesSz"
    case defaultTextStyle
  }
}
