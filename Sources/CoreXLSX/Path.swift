//
//  File.swift
//  CoreXLSX
//
//  Created by Max Desiatov on 19/02/2019.
//

public struct Path {
  public let value: String
  public let isRoot: Bool
  public let components: [Substring]

  public init(_ value: String) {
    self.value = value
    isRoot = value.first == "/"
    components = value.split(separator: "/")
  }
}
