//
//  Worksheet.swift
//  CoreXLSX
//
//  Created by Max Desiatov on 31/10/2018.
//

@available(*, deprecated, renamed: "Worksheet.Data")
public typealias SheetData = Worksheet.Data

@available(*, deprecated, renamed: "Worksheet.Properties")
public typealias SheetPr = Worksheet.Properties

@available(*, deprecated, renamed: "Worksheet.FormatProperties")
public typealias SheetFormatPr = Worksheet.FormatProperties

@available(*, deprecated, renamed: "Worksheet.Dimension")
public typealias WorksheetDimension = Worksheet.Dimension

public struct Worksheet: Codable {
  public struct Properties: Codable, Equatable {
    public let pageSetUpProperties: PageSetUpProperties?

    enum CodingKeys: String, CodingKey {
      case pageSetUpProperties = "pageSetUpPr"
    }
  }

  public struct Data: Codable {
    public let rows: [Row]

    enum CodingKeys: String, CodingKey {
      case rows = "row"
    }
  }

  public struct FormatProperties: Codable, Equatable {
    @available(*, deprecated, renamed: "defaultColumnWidth")
    public var defaultColWidth: String? {
      return defaultColumnWidth
    }

    public let defaultColumnWidth: String?

    public let defaultRowHeight: String?
    public let customHeight: String?
    public let outlineLevelRow: String?

    @available(*, deprecated, renamed: "outlineLevelColumn")
    public var outlineLevelCol: String? {
      return outlineLevelColumn
    }

    public let outlineLevelColumn: String?

    enum CodingKeys: String, CodingKey {
      case defaultColumnWidth = "defaultColWidth"
      case defaultRowHeight
      case customHeight
      case outlineLevelRow
      case outlineLevelColumn = "outlineLevelCol"
    }

    init(
      defaultColumnWidth: String? = nil,
      defaultRowHeight: String? = nil,
      customHeight: String? = nil,
      outlineLevelRow: String? = nil,
      outlineLevelColumn: String? = nil
    ) {
      self.defaultColumnWidth = defaultColumnWidth
      self.defaultRowHeight = defaultRowHeight
      self.customHeight = customHeight
      self.outlineLevelRow = outlineLevelRow
      self.outlineLevelColumn = outlineLevelColumn
    }
  }

  @available(*, deprecated, renamed: "properties")
  public var sheetPr: SheetPr? {
    return properties
  }

  public let properties: Properties?

  public struct Dimension: Codable {
    @available(*, deprecated, renamed: "reference")
    public var ref: String {
      return reference
    }

    public let reference: String

    enum CodingKeys: String, CodingKey {
      case reference = "ref"
    }
  }

  // swiftlint:disable:next line_length
  /// [Microsoft docs](https://docs.microsoft.com/en-us/dotnet/api/documentformat.openxml.spreadsheet.sheetdimension?view=openxml-2.8.1)
  public let dimension: Dimension?

  public let sheetViews: SheetViews?

  @available(*, deprecated, renamed: "formatProperties")
  public var sheetFormatPr: SheetFormatPr {
    return formatProperties ?? FormatProperties()
  }

  public let formatProperties: FormatProperties?
  public let columns: Columns?

  @available(*, deprecated, renamed: "columns")
  public var cols: Cols? {
    return columns
  }

  public let data: Data?

  @available(*, deprecated, renamed: "data")
  public var sheetData: SheetData {
    return data ?? Data(rows: [])
  }

  public let mergeCells: MergeCells?

  enum CodingKeys: String, CodingKey {
    case properties = "sheetPr"
    case dimension
    case sheetViews
    case formatProperties = "sheetFormatPr"
    case columns = "cols"
    case data = "sheetData"
    case mergeCells
  }
}

@available(*, deprecated, renamed: "PageSetUpProperties")
typealias PageSetUpPr = PageSetUpProperties

public struct PageSetUpProperties: Codable, Equatable {
  public let fitToPage: Bool?
  public let autoPageBreaks: Bool?
}

public struct SheetViews: Codable {
  public let items: [SheetView]

  enum CodingKeys: String, CodingKey {
    case items = "sheetView"
  }
}

public struct SheetView: Codable {
  public let workbookViewId: String
  public let showGridLines: Bool?
  public let defaultGridColor: String?
  public let pane: Pane?
}

public struct Pane: Codable {
  public let topLeftCell: String?
  public let xSplit: String?
  public let ySplit: String?
  public let activePane: String?
  public let state: String?
}

@available(*, deprecated, renamed: "Columns")
public typealias Cols = Columns

public struct Columns: Codable, Equatable {
  public let items: [Column]

  enum CodingKeys: String, CodingKey {
    case items = "col"
  }
}

@available(*, deprecated, renamed: "Column")
public typealias Col = Column

// swiftlint:disable line_length
/// [Microsoft
/// docs](https://docs.microsoft.com/en-us/dotnet/api/documentformat.openxml.spreadsheet.column?view=openxml-2.8.1)
public struct Column: Codable, Equatable {
  // swiftlint:enable line_length
  public let min: UInt32
  public let max: UInt32
  public let width: Double
  public let style: UInt32?
  public let customWidth: Bool?
}

public struct Row: Codable {
  public let reference: UInt

  @available(*, deprecated, renamed: "height")
  public var ht: String? {
    return height?.description
  }

  public let height: Double?
  public let customHeight: String?
  public let cells: [Cell]

  enum CodingKeys: String, CodingKey {
    case cells = "c"
    case reference = "r"
    case height = "ht"
    case customHeight
  }
}

public struct MergeCells: Codable {
  public let count: Int
  public let items: [MergeCell]

  enum CodingKeys: String, CodingKey {
    case items = "mergeCell"
    case count
  }
}

public struct MergeCell: Codable {
  /// A reference of format "A1:F1"
  public let reference: String

  @available(*, deprecated, renamed: "reference")
  public var ref: String {
    return reference
  }

  enum CodingKeys: String, CodingKey {
    case reference = "ref"
  }
}

public struct InlineString: Codable, Equatable {
  public let text: String?

  enum CodingKeys: String, CodingKey {
    case text = "t"
  }
}
