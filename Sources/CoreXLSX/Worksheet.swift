//
//  Worksheet.swift
//  CoreXLSX
//
//  Created by Max Desiatov on 31/10/2018.
//

import Foundation

public struct Worksheet: Codable {
  public let sheetPr: SheetPr?
  public let dimension: WorksheetDimension
  public let sheetViews: SheetViews
  public let sheetFormatPr: SheetFormatPr
  public let cols: Cols
  public let sheetData: SheetData
  public let mergeCells: MergeCells?
}

public struct SheetPr: Codable {
  public let pageSetUpPr: PageSetUpPr?
}

public struct PageSetUpPr: Codable {
  public let fitToPage: String
}

public struct WorksheetDimension: Codable {
  public let ref: String
}

public struct SheetViews: Codable {
  public let items: [SheetView]

  enum CodingKeys: String, CodingKey {
    case items = "sheetView"
  }
}

public struct SheetView: Codable {
  public let workbookViewId: String
  public let showGridLines: String?
  public let defaultGridColor: String?
  public let pane: Pane?
}

public struct Pane: Codable {
  public let topLeftCell: String
  public let xSplit: String
  public let ySplit: String
  public let activePane: String
  public let state: String
}

public struct SheetFormatPr: Codable {
  public let defaultColWidth: String?
  public let defaultRowHeight: String
  public let customHeight: String?
  public let outlineLevelRow: String?
  public let outlineLevelCol: String?
}

public struct Cols: Codable {
  public let items: [Col]

  enum CodingKeys: String, CodingKey {
    case items = "col"
  }
}

public struct Col: Codable {
  public let min: String
  public let max: String
  public let width: String
  public let style: String?
  public let customWidth: String
}

public struct SheetData: Codable {
  public let rows: [Row]

  enum CodingKeys: String, CodingKey {
    case rows = "row"
  }
}

public struct Row: Codable {
  public let r: String
  public let ht: String?
  public let customHeight: String?
  public let cells: [Cell]

  enum CodingKeys: String, CodingKey {
    case cells = "c"
    case r
    case ht
    case customHeight
  }
}

public struct Cell: Codable {
  public let reference: String
  public let type: String?
  public let s: String?
  public let inlineString: InlineString?
  public let formula: String?
  public let value: String?

  enum CodingKeys: String, CodingKey {
    case formula = "f"
    case value = "v"
    case inlineString = "is"
    case reference = "r"
    case type = "t"
    case s
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
  public let ref: String
}

public struct InlineString: Codable {
  let text: String

  enum CodingKeys: String, CodingKey {
    case text = "t"
  }
}
