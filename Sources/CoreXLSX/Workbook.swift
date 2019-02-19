//
//  Workbook.swift
//  CoreXLSX
//
//  Created by Max Desiatov on 23/11/2018.
//

public struct Workbook: Codable, Equatable {
  public struct Views: Codable, Equatable {
    public let items: [View]

    enum CodingKeys: String, CodingKey {
      case items = "workbookView"
    }
  }

  public struct View: Codable, Equatable {
    public let xWindow: Int
    public let yWindow: Int
    public let windowWidth: UInt
    public let windowHeight: UInt
  }

  public let views: Views

  public struct Sheets: Codable, Equatable {
    public let items: [Sheet]

    enum CodingKeys: String, CodingKey {
      case items = "sheet"
    }
  }

  public struct Sheet: Codable, Equatable {
    public let name: String?
    public let id: String
    public let relationship: String

    enum CodingKeys: String, CodingKey {
      case name
      case id = "sheetId"
      case relationship = "r:id"
    }
  }

  public let sheets: Sheets

  enum CodingKeys: String, CodingKey {
    case views = "bookViews"
    case sheets
  }
}
