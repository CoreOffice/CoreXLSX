//
//  Worksheet.swift
//  CoreXLSX
//
//  Created by Max Desiatov on 31/10/2018.
//

import Foundation

struct Worksheet: Codable {
  let sheetPr: SheetPr?
  let dimension: WorksheetDimension
  let sheetViews: SheetViews
  let sheetFormatPr: SheetFormatPr
  let cols: Cols
}

struct SheetPr: Codable {
  let pageSetUpPr: PageSetUpPr?
}

struct PageSetUpPr: Codable {
  let fitToPage: String
}

struct WorksheetDimension: Codable {
  let ref: String
}

struct SheetViews: Codable {
  let items: [SheetView]

  enum CodingKeys: String, CodingKey {
    case items = "sheetView"
  }
}

struct SheetView: Codable {
  let workbookViewId: String
  let showGridLines: String
  let defaultGridColor: String
  let pane: Pane
}

struct Pane: Codable {
  let topLeftCell: String
  let xSplit: String
  let ySplit: String
  let activePane: String
  let state: String
}

struct SheetFormatPr: Codable {
  let defaultColWidth: String
  let defaultRowHeight: String
  let customHeight: String
  let outlineLevelRow: String
  let outlineLevelCol: String
}

struct Cols: Codable {
  let items: [Col]

  enum CodingKeys: String, CodingKey {
    case items = "col"
  }
}

struct Col: Codable {
  let min: String
  let max: String
  let width: String
  let style: String
  let customWidth: String
}
