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
  public let columns: Columns

  @available(*, deprecated, renamed: "columns")
  public var cols: Cols {
    return columns
  }

  public let sheetData: SheetData
  public let mergeCells: MergeCells?

  enum CodingKeys: String, CodingKey {
    case sheetPr
    case dimension
    case sheetViews
    case sheetFormatPr
    case columns = "cols"
    case sheetData
    case mergeCells
  }

  /// Return all cells that are contained in a given worksheet and collection of
  /// columns.
  public func cells<T>(atColumns columns: T) -> [Cell]
  where T: Collection, T.Element == ColumnReference {
    return sheetData.rows.map {
      return $0.cells.filter { columns.contains($0.reference.column) }
    }
    .reduce([]) { $0 + $1 }
  }

  /// Return all cells that are contained in a given worksheet and collection of
  /// rows.
  public func cells<T>(atRows rows: T) -> [Cell]
  where T: Collection, T.Element == UInt {
    return sheetData.rows.filter { rows.contains($0.reference) }
      .reduce([]) { $0 + $1.cells }
  }

  /// Return all cells that are contained in a given worksheet and collections
  /// of rows and columns.
  public func cells<T1, T2>(atColumns columns: T1, rows: T2) -> [Cell]
    where T1: Collection, T1.Element == ColumnReference,
    T2: Collection, T2.Element == UInt {
      return sheetData.rows.filter { rows.contains($0.reference) }.map {
        return $0.cells.filter { columns.contains($0.reference.column) }
      }
      .reduce([]) { $0 + $1 }
  }
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

public struct Column: Codable, Equatable {
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
  public let reference: UInt
  public let ht: String?
  public let customHeight: String?
  public let cells: [Cell]

  enum CodingKeys: String, CodingKey {
    case cells = "c"
    case reference = "r"
    case ht
    case customHeight
  }
}

public struct Cell: Codable, Equatable {
  public let reference: CellReference
  public let type: String?

  /// Attribute "s" in a cell is an index into the styles table,
  /// while the cell type "s" corresponds to the shared string table.
  /// XMLCoder as version 0.1 can't distinguish between an attribute and a
  /// node having the same name, so the property stays name `s` until
  /// that's fixed.
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
  let text: String?

  enum CodingKeys: String, CodingKey {
    case text = "t"
  }
}
