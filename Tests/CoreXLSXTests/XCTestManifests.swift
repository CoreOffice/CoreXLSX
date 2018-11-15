import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(CoreXLSXTests.allTests),
    testCase(RelationshipsTests.allTests),
  ]
}
#endif
