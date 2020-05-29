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
//  Created by Max Desiatov on 11/04/2019.
//

@testable import CoreXLSX
import XCTest
import XMLCoder

private let namespaceXML = """
<?xml version="1.0" encoding="utf-8"?>
<x:worksheet \
xmlns:x="http://schemas.openxmlformats.org/spreadsheetml/2006/main">
  <x:sheetData>
    <x:row r="1">
      <x:c t="str" r="A1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="B1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="C1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="D1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="E1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="F1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="G1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="H1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="I1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="J1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="K1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="L1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="M1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="N1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="O1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="P1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="Q1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="R1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="S1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="T1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="U1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="V1">
        <x:v>Scolumn name</x:v>
      </x:c>
      <x:c t="str" r="W1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="X1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="Y1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="Z1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="AA1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="AB1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="AC1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="AD1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="AE1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="AF1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="AG1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="AH1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="AI1">
        <x:v>column name</x:v>
      </x:c>
      <x:c t="str" r="AJ1">
        <x:v>column name</x:v>
      </x:c>
    </x:row>
    <x:row r="2">
    </x:row>
  </x:sheetData>
</x:worksheet>
""".data(using: .utf8)!

final class NamespacesTests: XCTestCase {
  func testNamespaces() throws {
    let decoder = XMLDecoder()
    decoder.shouldProcessNamespaces = true

    let worksheet = try decoder.decode(Worksheet.self, from: namespaceXML)
    XCTAssertEqual(worksheet.data?.rows[0].cells.count, 36)
  }
}
