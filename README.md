# CoreXLSX

## Excel spreadsheet (XLSX) format parser written in pure Swift

[![Build Status](https://dev.azure.com/max0484/max/_apis/build/status/MaxDesiatov.CoreXLSX?branchName=master)](https://dev.azure.com/max0484/max/_build/latest?definitionId=2&branchName=master)
[![Version](https://img.shields.io/cocoapods/v/CoreXLSX.svg?style=flat)](https://cocoapods.org/pods/CoreXLSX)
[![License](https://img.shields.io/cocoapods/l/CoreXLSX.svg?style=flat)](https://cocoapods.org/pods/CoreXLSX)
![Platform](https://img.shields.io/badge/platform-watchos%20%7C%20ios%20%7C%20tvos%20%7C%20macos%20%7C%20linux-lightgrey.svg?style=flat)
[![Coverage](https://img.shields.io/codecov/c/github/MaxDesiatov/CoreXLSX/master.svg?style=flat)](https://codecov.io/gh/maxdesiatov/CoreXLSX)

CoreXLSX is a library focused on representing the low-level structure
of XML-based XLSX spreadsheet format. It allows you to open a spreadsheet 
archive and map its XML structure into model types expressed directly
in Swift.

## Example

To run the example project, clone the repo, and run `pod install` from the
Example directory first.

Model types in `CoreXLSX` directly map internal structure of XLSX format with
more sensible naming applied to a few attributes. The API is pretty simple:

```swift
import CoreXLSX

guard let file = XLSXFile(filepath: "./categories.xlsx") else {
  fatalError("XLSX file corrupted or does not exist")
}

for path in try file.parseWorksheetPaths() {
  let ws = try file.parseWorksheet(at: path)
  for row in ws.data?.rows ?? [] {
    for c in row.cells {
      print(c)
    }
  }
}
```

This prints every cell from every worksheet in the given XLSX file. Please refer
to the [`Worksheet`
model](https://github.com/MaxDesiatov/CoreXLSX/blob/master/Sources/CoreXLSX/Worksheet/Worksheet.swift)
for more atttributes you might need to read from a parsed file.

 ### Shared strings

Some cells (usually with strings) have their values shared in a separate model
type, which you can get by evaluating `try file.parseSharedString()`. You can
refer to the [`SharedStrings`
model](https://github.com/MaxDesiatov/CoreXLSX/blob/master/Sources/CoreXLSX/SharedStrings.swift)
for the full list of its properties.

Here's how you can get all shared strings in column "C" for example:

```swift
let sharedStrings = try file.parseSharedStrings()
let columnCStrings = ws.cells(atColumns: [ColumnReference("C")!])
  // in format internals "s" stands for "shared"
  .filter { $0.type == "s" }
  .compactMap { $0.value }
  .compactMap { Int($0) }
  .compactMap { sharedStrings.items[$0].text }
```

### Styles

Since version 0.5.0 you can parse style information from the archive with the
new `parseStyles()` function. Please refer to the [`Styles`
model](https://github.com/MaxDesiatov/CoreXLSX/blob/master/Sources/CoreXLSX/Styles.swift)
for more details. You should also note that not all XLSX files contain style
information, so you should be prepared to handle the errors thrown from
`parseStyles()` function in that case. 


Here's a short example that fetches a list of fonts used:

```swift
let styles = try file.parseStyles()
let fonts = styles.fonts?.items.compactMap { $0.name?.value }
```

## Reporting compatibility issues

If you stumble upon a file that can't be parsed, please [file an
issue](https://github.com/MaxDesiatov/CoreXLSX/issues) posting the exact error
message. Thanks to use of standard Swift `Codable` protocol, detailed errors are
generated listing a missing attribute, so it can be easily added to the model
enabling broader format support. Attaching a file that can't be parsed would
also greatly help in diagnosing issues. If these files contain any sensitive
data, we suggest obfuscating or generating fake data with same tools that
generated original files, assuming the issue can still be reproduced this way.

If the whole file can't be attached, try passing a sufficiently large value
(between 10 and 20 usually works well) to `errorContextLength` argument of
`XLSXFile` initializer. This will bundle the failing XML snippet with the debug
description of thrown errors. Please also attach the full debug description if
possible when reporting issues.

## How does it work?

Since every XLSX file is a zip archive of XML files, `CoreXLSX` uses
[`XMLCoder`](https://github.com/MaxDesiatov/XMLCoder) library and standard
`Codable` protocols to map XML nodes and atrributes into plain Swift structs.
[`ZIPFoundation`](https://www.github.com/weichsel/ZIPFoundation) is used for
in-memory decompression of zip archives. A detailed description is [available
here](https://desiatov.com/swift-codable-xlsx/).

## Requirements

**Apple Platforms**
- Xcode 10.0 or later
- Swift 4.2 or later
- iOS 9.0 / watchOS 2.0 / tvOS 9.0 / macOS 10.11 or later deployment targets

**Linux**
- Ubuntu 14.04 or later
- Swift 5.0.1 or later

## Installation

### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager/) is a tool for
managing the distribution of Swift code. It’s integrated with the Swift build
system to automate the process of downloading, compiling, and linking
dependencies on all platforms.

Once you have your Swift package set up, adding `CoreXLSX` as a dependency is as
easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
  .package(url: "https://github.com/MaxDesiatov/CoreXLSX.git",
           .upToNextMajor(from: "0.9.1"))
]
```

### CocoaPods

CoreXLSX is available through [CocoaPods](https://cocoapods.org) on Apple's
platforms. To install it, simply add `pod 'CoreXLSX', '~> 0.9.1'` to your
`Podfile` like shown here:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
use_frameworks!
target '<Your Target Name>' do
  pod 'CoreXLSX', '~> 0.9.1'
end
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a dependency manager that
builds your dependencies and provides you with binary frameworks on Apple's
platforms.

Carthage can be installed with [Homebrew](https://brew.sh/) using the following
command:

```bash
$ brew update
$ brew install carthage
```

Inside of your `Cartfile`, add GitHub path to `CoreXLSX` and its latest version:

```ogdl
github "MaxDesiatov/CoreXLSX" ~> 0.9.1
```

Then, run the following command to build the framework:

```bash
$ carthage update
```

Drag the built frameworks (including the subdependencies `XMLCoder` and
`ZIPFoundation`) into your Xcode project.

## Contributing

For development work and for running the tests in Xcode you need to run 
`carthage bootstrap` in the root directory of the cloned repository first.
Then you can open the `CoreXLSX.xcodeproj` from the same directory and select 
the `CoreXLSXmacOS` scheme. This is the only scheme that has the tests
set up, but you can also build any other scheme (e.g. `CoreXLSXiOS`) to make
sure it builds on other platforms.

If you prefer not to work with Xcode, the project fully supports SwiftPM and the
usual workflow with `swift build` and `swift test` should work, otherwise please
[report this as a bug](https://github.com/MaxDesiatov/CoreXLSX/issues/new).

### Code of Conduct

This project adheres to the [Contributor Covenant Code of
Conduct](https://github.com/MaxDesiatov/CoreXLSX/blob/master/CODE_OF_CONDUCT.md).
By participating, you are expected to uphold this code. Please report
unacceptable behavior to corexlsx@desiatov.com.

## Maintainers

[Max Desiatov](https://desiatov.com), [Matvii
Hodovaniuk](https://matvii.hodovani.uk)

## License

CoreXLSX is available under the Apache 2.0 license. See the
[LICENSE](https://github.com/MaxDesiatov/CoreXLSX/blob/master/LICENSE.md) file
for more info.
