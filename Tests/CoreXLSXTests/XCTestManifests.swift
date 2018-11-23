import XCTest

#if os(Linux)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(CoreXLSXTests.allTests),
    testCase(RelationshipsTests.allTests),
    testCase(CellReferenceTests.allTests),
  ]
}
#endif
