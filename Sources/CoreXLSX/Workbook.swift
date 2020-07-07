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
    public let xWindow: Int?
    public let yWindow: Int?
    public let windowWidth: UInt?
    public let windowHeight: UInt?
  }

  public let views: Views?

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
