//
//  Styles.swift
//  CoreXLSX
//
//  Created by Max Desiatov on 16/03/2019.
//

struct Style {
  
}

public struct Color: Codable {
  public let indexed: Int?
  public let auto: Int?
}

public struct NumberFormats: Codable {
  public let items: [NumberFormat]
  public let count: Int

  enum CodingKeys: String, CodingKey {
    case items = "numFmt"
    case count
  }
}

public struct NumberFormat: Codable {
  public let id: Int
  public let formatCode: String

  enum CodingKeys: String, CodingKey {
    case id = "numFmtId"
    case formatCode
  }
}

public struct Fonts: Codable {
  public let items: [Font]
  public let count: Int

  enum CodingKeys: String, CodingKey {
    case items = "font"
    case count
  }
}

public struct Font: Codable {
  public struct Size: Codable {
    public let value: Double

    enum CodingKeys: String, CodingKey {
      case value = "val"
    }
  }

  public struct Name: Codable {
    public let value: String

    enum CodingKeys: String, CodingKey {
      case value = "val"
    }
  }

  public struct Bold: Codable {
    public let value: Int

    enum CodingKeys: String, CodingKey {
      case value = "val"
    }
  }

  public let size: Size?
  public let color: Color?
  public let name: Name?
  public let bold: Bold?

  enum CodingKeys: String, CodingKey {
    case size = "sz"
    case color
    case name
    case bold = "b"
  }
}

public struct Fills: Codable {
  public let items: [Font]
  public let count: Int

  enum CodingKeys: String, CodingKey {
    case items = "fill"
    case count
  }
}

public struct Fill: Codable {
  public let patternType: String
  public let foregroundColor: Color?
  public let backgroundColor: Color?

  enum CodingKeys: String, CodingKey {
    case foregroundColor = "fgColor"
    case backgroundColor = "bgColor"
    case patternType
  }
}
