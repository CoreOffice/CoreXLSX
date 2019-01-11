//
//  Cell.swift
//  CoreXLSX
//
//  Created by Max Desiatov on 24/11/2018.
//

public struct Cell: Codable, Equatable {
  public let reference: CellReference
  public let type: String?

  /// FIXME: Attribute "s" in a cell is an index into the styles table,
  /// while the cell type "s" corresponds to the shared string table.
  /// Can XMLCoder distinguish between an attribute and an
  /// element having the same name?
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
