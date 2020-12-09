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
//  Created by Max Desiatov on 14/11/2018.
//

public struct CellReference {
  public let column: ColumnReference
  public let row: UInt

  public init(_ column: ColumnReference, _ row: UInt) {
    self.column = column
    self.row = row
  }
}

extension CellReference: Equatable {
  public static func ==(lhs: CellReference, rhs: CellReference) -> Bool {
    lhs.column == rhs.column && lhs.row == rhs.row
  }
}

extension CellReference: CustomStringConvertible {
  public var description: String {
    "\(column)\(row)"
  }
}

extension CellReference: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let reference = try container.decode(String.self)

    guard let lastLetterIndex = reference.lastIndex(where: {
      $0.unicodeScalars.allSatisfy {
        ColumnReference.allowedCharacters.contains($0)
      }
    }) else {
      throw CoreXLSXError.invalidCellReference
    }

    let separatorIndex = reference.index(after: lastLetterIndex)

    guard let column =
      ColumnReference(reference.prefix(upTo: separatorIndex))
    else {
      throw CoreXLSXError.invalidCellReference
    }

    guard let cell = UInt(reference.suffix(from: separatorIndex)) else {
      throw CoreXLSXError.invalidCellReference
    }

    self.init(column, cell)
  }
}

extension CellReference: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(description)
  }
}
