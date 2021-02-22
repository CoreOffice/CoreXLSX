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

@testable import CoreXLSX
import XCTest

final class CommentsTests: XCTestCase {
  func testComments() throws {
    guard let file =
      XLSXFile(filepath: "\(fixturesPath)/comments.xlsx")
    else {
      XCTFail("failed to open the file")
      return
    }
    let paths = try file.parseWorksheetPaths()
    let comments = try file.parseComments(forWorksheet: paths[0])
    XCTAssertEqual(comments.commentList.itemsByReference["A1"]?.text.plain,
                   "my note")
  }
}
