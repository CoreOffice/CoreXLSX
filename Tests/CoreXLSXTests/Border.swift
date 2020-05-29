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
//  Created by Max Desiatov on 24/05/2019.
//

@testable import CoreXLSX
import XCTest
@testable import XMLCoder

private let xml = """
<borders count="1">
<border/>
</borders>
""".data(using: .utf8)!

final class BorderTest: XCTestCase {
  func testSingleEmpty() throws {
    let result = try XMLDecoder().decode(Borders.self, from: xml)
    XCTAssertEqual(result.count, 1)
    XCTAssertEqual(result.items[0], Border())
  }
}
