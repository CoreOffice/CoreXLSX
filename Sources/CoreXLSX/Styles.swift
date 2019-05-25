//
//  Styles.swift
//  CoreXLSX
//
//  Created by Max Desiatov on 16/03/2019.
//

public struct Styles: Codable, Equatable {
  public let numberFormats: NumberFormats?
  public let fonts: Fonts?
  public let fills: Fills?
  public let borders: Borders?
  public let cellStyleFormats: CellStyleFormats?
  public let cellFormats: CellFormats?
  public let differentialFormats: DifferentialFormats?
  public let tableStyles: TableStyles?
  public let cellStyles: CellStyles?
  public let colors: Colors?

  enum CodingKeys: String, CodingKey {
    case numberFormats = "numFmts"
    case fonts
    case fills
    case borders
    case cellStyleFormats = "cellStyleXfs"
    case cellFormats = "cellXfs"
    case differentialFormats = "dxfs"
    case cellStyles
    case tableStyles
    case colors
  }
}

public struct Color: Codable, Equatable {
  public let indexed: Int?
  public let auto: Int?
  public let rgb: String?
}

public struct NumberFormats: Codable, Equatable {
  public let items: [NumberFormat]
  public let count: Int

  enum CodingKeys: String, CodingKey {
    case items = "numFmt"
    case count
  }
}

public struct NumberFormat: Codable, Equatable {
  public let id: Int
  public let formatCode: String

  enum CodingKeys: String, CodingKey {
    case id = "numFmtId"
    case formatCode
  }
}

public struct Fonts: Codable, Equatable {
  public let items: [Font]
  public let count: Int

  enum CodingKeys: String, CodingKey {
    case items = "font"
    case count
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    count = try container.decode(Int.self, forKey: .count)
    items = try container.decode([Font?].self, forKey: .items)
      .map { $0 ?? Font() }
  }

  init(items: [Font], count: Int) {
    self.items = items
    self.count = count
  }
}

public struct Font: Codable, Equatable {
  public struct Size: Codable, Equatable {
    public let value: Double

    enum CodingKeys: String, CodingKey {
      case value = "val"
    }
  }

  public struct Name: Codable, Equatable {
    public let value: String

    enum CodingKeys: String, CodingKey {
      case value = "val"
    }
  }

  public struct Bold: Codable, Equatable {
    public let value: Bool?

    enum CodingKeys: String, CodingKey {
      case value = "val"
    }
  }

  public struct Italic: Codable, Equatable {
    public let value: Bool?

    enum CodingKeys: String, CodingKey {
      case value = "val"
    }
  }

  public struct Strike: Codable, Equatable {
    public let value: Bool?

    enum CodingKeys: String, CodingKey {
      case value = "val"
    }
  }

  public let size: Size?
  public let color: Color?
  public let name: Name?
  public let bold: Bold?
  public let italic: Italic?
  public let strike: Strike?

  enum CodingKeys: String, CodingKey {
    case size = "sz"
    case color
    case name
    case bold = "b"
    case italic = "i"
    case strike
  }

  init(
    size: Size? = nil,
    color: Color? = nil,
    name: Name? = nil,
    bold: Bold? = nil,
    italic: Italic? = nil,
    strike: Strike? = nil
  ) {
    self.size = size
    self.color = color
    self.name = name
    self.bold = bold
    self.italic = italic
    self.strike = strike
  }
}

public struct Fills: Codable, Equatable {
  public let items: [Fill]
  public let count: Int

  enum CodingKeys: String, CodingKey {
    case items = "fill"
    case count
  }
}

public struct Fill: Codable, Equatable {
  public let patternFill: PatternFill
}

public struct PatternFill: Codable, Equatable {
  public let patternType: String
  public let foregroundColor: Color?
  public let backgroundColor: Color?

  enum CodingKeys: String, CodingKey {
    case foregroundColor = "fgColor"
    case backgroundColor = "bgColor"
    case patternType
  }
}

public struct Borders: Codable, Equatable {
  public let items: [Border]
  public let count: Int

  enum CodingKeys: String, CodingKey {
    case items = "border"
    case count
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    count = try container.decode(Int.self, forKey: .count)
    items = try container.decode([Border?].self, forKey: .items)
      .map { $0 ?? Border() }
  }
}

public struct Border: Codable, Equatable {
  public struct Value: Codable, Equatable {
    public let color: Color?
    public let style: String?
  }

  public let left: Value?
  public let right: Value?
  public let top: Value?
  public let bottom: Value?
  public let diagonal: Value?
  public let horizontal: Value?
  public let vertical: Value?

  init() {
    left = nil
    right = nil
    top = nil
    bottom = nil
    diagonal = nil
    horizontal = nil
    vertical = nil
  }
}

public struct CellStyleFormats: Codable, Equatable {
  public let items: [Format]
  public let count: Int

  enum CodingKeys: String, CodingKey {
    case items = "xf"
    case count
  }
}

public struct CellFormats: Codable, Equatable {
  public let items: [Format]
  public let count: Int

  enum CodingKeys: String, CodingKey {
    case items = "xf"
    case count
  }
}

/// [docs](http://www.datypic.com/sc/ooxml/t-ssml_CT_Xf.html)
public struct Format: Codable, Equatable {
  public struct Alignment: Codable, Equatable {
    public let vertical: String?
    public let horizontal: String?
    public let wrapText: Bool?
  }

  public let numberFormatId: Int
  public let borderId: Int?
  public let fillId: Int?
  public let fontId: Int
  public let applyNumberFormat: Bool?
  public let applyFont: Bool?
  public let applyFill: Bool?
  public let applyBorder: Bool?
  public let applyAlignment: Bool?
  public let applyProtection: Bool?
  public let alignment: Alignment?

  enum CodingKeys: String, CodingKey {
    case numberFormatId = "numFmtId"
    case borderId
    case fillId
    case fontId
    case applyNumberFormat
    case applyFont
    case applyFill
    case applyBorder
    case applyAlignment
    case applyProtection
    case alignment
  }
}

public struct CellStyles: Codable, Equatable {
  public let items: [CellStyle]
  public let count: Int

  enum CodingKeys: String, CodingKey {
    case items = "cellStyle"
    case count
  }
}

public struct CellStyle: Codable, Equatable {
  public let name: String
  public let formatId: Int
  public let builtinId: Int

  enum CodingKeys: String, CodingKey {
    case formatId = "xfId"
    case name
    case builtinId
  }
}

/// Described at http://officeopenxml.com/SSstyles.php
public struct DifferentialFormat: Codable, Equatable {
  public let font: Font?
  public let border: Border?
}

public struct DifferentialFormats: Codable, Equatable {
  public let items: [Format]
  public let count: Int

  enum CodingKeys: String, CodingKey {
    case items = "dxf"
    case count
  }
}

public struct TableStyles: Codable, Equatable {
  public let count: Int
  public let items: [TableStyle]

  enum CodingKeys: String, CodingKey {
    case count
    case items = "tableStyle"
  }
}

public struct TableStyle: Codable, Equatable {
  public struct Element: Codable, Equatable {
    public let type: String
  }

  public let pivot: Bool
  public let name: String
  public let count: Int
  public let elements: [Element]

  enum CodingKeys: String, CodingKey {
    case pivot
    case count
    case name
    case elements = "tableStyleElement"
  }
}

public struct Colors: Codable, Equatable {
  public struct Indexed: Codable, Equatable {
    public let rgbColors: [Color]

    enum CodingKeys: String, CodingKey {
      case rgbColors = "rgbColor"
    }
  }

  public let indexed: Indexed

  enum CodingKeys: String, CodingKey {
    case indexed = "indexedColors"
  }
}
