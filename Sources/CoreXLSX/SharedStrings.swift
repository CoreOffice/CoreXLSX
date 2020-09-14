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
//  Created by Max Desiatov on 18/11/2018.
//

/**
  Strings in spreadsheet internals are frequently represented as strings
  shared between multiple worksheets. To parse a string value from a cell
  you should use `stringValue(_: SharedStrings)` function on `Cell` together with
  `parseSharedString()` on your `XLSXFile` instance.

  Here's how you can get all strings in column "C" for example:

  ```swift
  if let sharedStrings = try file.parseSharedStrings() {
    let columnCStrings = worksheet.cells(atColumns: [ColumnReference("C")!])
      .compactMap { $0.stringValue(sharedStrings) }
  }
  ```

 Corresponding attributes and nodes that map to the properties of `SharedStrings` are documented in
 [Microsoft
 docs](https://docs.microsoft.com/en-us/office/open-xml/working-with-the-shared-string-table).
 */
public struct SharedStrings: Codable, Equatable {
  // swiftlint:enable line_length
  public struct Item: Codable, Equatable {
    public let text: String?
    public let richText: [RichText]

    enum CodingKeys: String, CodingKey {
      case text = "t"
      case richText = "r"
    }
  }

  public let uniqueCount: UInt?
  public let items: [Item]

  enum CodingKeys: String, CodingKey {
    case items = "si"
    case uniqueCount
  }
}

public struct RichText: Codable, Equatable {
  public struct Family: Codable, Equatable {
    public let value: String

    enum CodingKeys: String, CodingKey {
      case value = "val"
    }
  }

  public struct Scheme: Codable, Equatable {
    public let value: String

    enum CodingKeys: String, CodingKey {
      case value = "val"
    }
  }

  public struct Size: Codable, Equatable {
    public let value: String

    enum CodingKeys: String, CodingKey {
      case value = "val"
    }
  }

  public struct Color: Codable, Equatable {
    let theme: String?
    let rgb: String?
  }

  public struct Font: Codable, Equatable {
    public let value: String

    enum CodingKeys: String, CodingKey {
      case value = "val"
    }
  }

  public struct Properties: Codable, Equatable {
    public let size: Size?
    public let color: Color?
    public let font: Font?
    public let family: Family?
    public let scheme: Scheme?

    enum CodingKeys: String, CodingKey {
      case size = "sz"
      case color
      case font = "rFont"
      case family
      case scheme
    }
  }

  public let properties: Properties?
  public let text: String?

  enum CodingKeys: String, CodingKey {
    case properties = "rPr"
    case text = "t"
  }
}
