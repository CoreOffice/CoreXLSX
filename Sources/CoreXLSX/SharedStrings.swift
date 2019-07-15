//
//  SharedStrings.swift
//  CoreXLSX
//
//  Created by Max Desiatov on 18/11/2018.
//

// swiftlint:disable line_length
/// Attributes and nodes are documented in [Microsoft
/// docs](https://docs.microsoft.com/en-us/office/open-xml/working-with-the-shared-string-table)
public struct SharedStrings: Codable, Equatable {
  // swiftlint:enable line_length
  public struct Item: Codable, Equatable {
    public let text: String?
    public let richText: [RichText]

    enum CodingKeys: String, CodingKey {
      case text = "t"
      case richText = "r"
    }
  }

  public let uniqueCount: UInt?
  public let items: [Item]

  enum CodingKeys: String, CodingKey {
    case items = "si"
    case uniqueCount
  }
}

public struct RichText: Codable, Equatable {
  public struct Family: Codable, Equatable {
    public let value: String

    enum CodingKeys: String, CodingKey {
      case value = "val"
    }
  }

  public struct Scheme: Codable, Equatable {
    public let value: String

    enum CodingKeys: String, CodingKey {
      case value = "val"
    }
  }

  public struct Size: Codable, Equatable {
    public let value: String

    enum CodingKeys: String, CodingKey {
      case value = "val"
    }
  }

  public struct Color: Codable, Equatable {
    let theme: String?
    let rgb: String?
  }

  public struct Font: Codable, Equatable {
    public let value: String

    enum CodingKeys: String, CodingKey {
      case value = "val"
    }
  }

  public struct Properties: Codable, Equatable {
    public let size: Size
    public let color: Color?
    public let font: Font
    public let family: Family?
    public let scheme: Scheme?

    enum CodingKeys: String, CodingKey {
      case size = "sz"
      case color
      case font = "rFont"
      case family
      case scheme
    }
  }

  public let properties: Properties?
  public let text: String?

  enum CodingKeys: String, CodingKey {
    case properties = "rPr"
    case text = "t"
  }
}
