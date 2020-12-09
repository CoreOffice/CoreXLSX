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
      defaultColumnWidth
    }

    public let defaultColumnWidth: String?

    public let defaultRowHeight: String?
    public let customHeight: String?
    public let outlineLevelRow: String?

    @available(*, deprecated, renamed: "outlineLevelColumn")
    public var outlineLevelCol: String? {
      outlineLevelColumn
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
    properties
  }

  public let properties: Properties?

  public struct Dimension: Codable {
    @available(*, deprecated, renamed: "reference")
    public var ref: String {
      reference
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
    formatProperties ?? FormatProperties()
  }

  public let formatProperties: FormatProperties?
  public let columns: Columns?

  @available(*, deprecated, renamed: "columns")
  public var cols: Cols? {
    columns
  }

  public let data: Data?

  @available(*, deprecated, renamed: "data")
  public var sheetData: SheetData {
    data ?? Data(rows: [])
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

/** An array of `Column` values. This type directly maps the internal XML structure of the
 `.xlsx` format.
 */
public struct Columns: Codable, Equatable {
  public let items: [Column]

  enum CodingKeys: String, CodingKey {
    case items = "col"
  }
}

@available(*, deprecated, renamed: "Column")
public typealias Col = Column

/** The styling information for a given column. Full specification for the internals of this type
 is available in [Microsoft
 docs](https://docs.microsoft.com/en-us/dotnet/api/documentformat.openxml.spreadsheet.column?view=openxml-2.8.1).
 */
public struct Column: Codable, Equatable {
  /// The first column where this formatting information applies.
  public let min: Int

  /// The last column where this formatting information applies.
  public let max: Int

  /// Width of a column in width values of widest digist in normal font style.
  public let width: Double

  /// Default style for related columns.
  public let style: UInt32?

  /// Set to `true` when width for related columns differs from the default.
  public let customWidth: Bool?
}

/** The primary storage for spreadsheet cells.
 */
public struct Row: Codable {
  public let reference: UInt

  @available(*, deprecated, renamed: "height")
  public var ht: String? {
    height?.description
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
  public let count: Int?
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
    reference
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
