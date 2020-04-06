//
//  Cell.swift
//  CoreXLSX
//
//  Created by Max Desiatov on 24/11/2018.
//

/// [docs](http://www.datypic.com/sc/ooxml/t-ssml_ST_CellType.html)
public enum CellType: String, Codable {
  case bool = "b"
  case number = "n"
  case error = "e"
  case sharedString = "s"
  case string = "str"
  case inlineStr
}

// swiftlint:disable:next line_length
/// [docs](https://wiki.ucl.ac.uk/display/~ucftpw2/2013/10/22/Using+git+for+version+control+of+Excel+spreadsheets+-+part+2+of+3)
public struct Cell: Codable, Equatable {
  public let reference: CellReference
  public let type: CellType?

  // FIXME: Attribute "s" in a cell is an index into the styles table,
  // while the cell type "s" corresponds to the shared string table.
  // Can XMLCoder distinguish between an attribute and an
  // element having the same name?
  public let s: String?
  public let inlineString: InlineString?
  public let formula: Formula?
  public let value: String?

  public struct Formula: Codable, Equatable {
    public let calculationIndex: Int?
    public let value: String?

    enum CodingKeys: String, CodingKey {
      case calculationIndex = "ca"
      case value = ""
    }
  }

  enum CodingKeys: String, CodingKey {
    case formula = "f"
    case value = "v"
    case inlineString = "is"
    case reference = "r"
    case type = "t"
    case s
  }
}
