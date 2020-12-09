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

public struct Comments: Codable, Equatable {
  public let commentList: CommentList
}

public struct CommentList: Codable, Equatable {
  public let items: [Comment]

  public var itemsByReference: [String: Comment] {
    Dictionary(uniqueKeysWithValues: items.map { ($0.reference, $0) })
  }

  enum CodingKeys: String, CodingKey {
    case items = "comment"
  }
}

public struct Comment: Codable, Equatable {
  public let reference: String
  public let text: Text

  enum CodingKeys: String, CodingKey {
    case reference = "ref"
    case text
  }
}

public struct Text: Codable, Equatable {
  public let plain: String?

  enum CodingKeys: String, CodingKey {
    case plain = "t"
  }
}
