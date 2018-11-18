//
//  SharedStrings.swift
//  CoreXLSX
//
//  Created by Max Desiatov on 18/11/2018.
//

struct SharedStrings: Codable {
  struct Item: Codable {
    let text: String?
    let richText: RichText?

    enum CodingKeys: String, CodingKey {
      case text = "t"
      case richText = "r"
    }
  }

  let uniqueCount: UInt
  let items: [Item]

  enum CodingKeys: String, CodingKey {
    case items = "si"
    case uniqueCount
  }
}

struct RichText: Codable {
  struct Family: Codable {
    let value: String

    enum CodingKeys: String, CodingKey {
      case value = "val"
    }
  }

  struct Scheme: Codable {
    let value: String

    enum CodingKeys: String, CodingKey {
      case value = "val"
    }
  }

  struct Size: Codable {
    let value: String

    enum CodingKeys: String, CodingKey {
      case value = "val"
    }
  }

  struct Font: Codable {
    let value: String

    enum CodingKeys: String, CodingKey {
      case value = "val"
    }
  }

  struct Properties: Codable {
    let size: Size
    let color: Color
    let font: Font
    let family: Family
    let scheme: Scheme

    enum CodingKeys: String, CodingKey {
      case size = "sz"
      case color
      case font = "rFont"
      case family
      case scheme
    }
  }

  let properties: Properties
}

struct Color: Codable {
  let theme: String?
  let rgb: String?
}
