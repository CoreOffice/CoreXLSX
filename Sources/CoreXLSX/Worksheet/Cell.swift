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
//  Created by Max Desiatov on 24/11/2018.
//

/** The type of the value stored in a spreadsheet cell. The specification for the internals is
 available at [datypic.com](http://www.datypic.com/sc/ooxml/t-ssml_ST_CellType.html).
 */
public enum CellType: String, Codable {
  case bool = "b"
  case date = "d"
  case number = "n"
  case error = "e"
  case sharedString = "s"
  case string = "str"
  case inlineStr
}

/**
 The representation of a spreadsheet cell.
 More details of how cells are encoded in `.xlsx` internals are available at
 [wiki.ucl.ac.uk](https://wiki.ucl.ac.uk/display/~ucftpw2/2013/10/22/Using+git+for+version+control+of+Excel+spreadsheets+-+part+2+of+3).
 */
public struct Cell: Codable, Equatable {
  public let reference: CellReference
  public let type: CellType?
  public let styleIndex: Int?

  /** Not every string in a cell is an inline string. You should use `stringValue(_: SharedStrings)`
   on the `Cell` type, supplying it the result of `parseSharedStrings()` called on your `XLSXFile`
   instance first. If any of those calls return `nil`, you can then attempt to look for the value in
   `inlineString` or `value` properties.
   */
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
    case styleIndex = "s"
  }
}
