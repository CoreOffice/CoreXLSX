//
//  Comments.swift
//  CoreXLSX
//

public struct Comments: Codable, Equatable {
  public let commentList: CommentList
}

public struct CommentList: Codable, Equatable {
  public let items: [Comment]

  public var itemsByReference: [String: Comment] {
    return Dictionary(uniqueKeysWithValues: items.map { ($0.reference, $0) })
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
