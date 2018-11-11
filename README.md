# CoreXLSX

## Excel spreadsheet (XLSX) format support in pure Swift 

[![CI Status](https://img.shields.io/travis/MaxDesiatov/CoreXLSX.svg?style=flat)](https://travis-ci.org/MaxDesiatov/CoreXLSX)
[![Version](https://img.shields.io/cocoapods/v/CoreXLSX.svg?style=flat)](https://cocoapods.org/pods/CoreXLSX)
[![License](https://img.shields.io/cocoapods/l/CoreXLSX.svg?style=flat)](https://cocoapods.org/pods/CoreXLSX)
[![Platform](https://img.shields.io/cocoapods/p/CoreXLSX.svg?style=flat)](https://cocoapods.org/pods/CoreXLSX)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Model types in `CoreXLSX` directly map internal structure of XLSX format with
more sensible naming applied to a few attributes. The API is pretty simple:

```swift
import CoreXLSX

guard let file = XLSXFile(filepath: "./categories.xlsx") else {
  fatalError("XLSX file corrupted or does not exist")
}

for path in try file.parseWorksheetPaths() {
  let ws = try file.parseWorksheet(at: path)
  for row in ws.sheetData.rows {
    for c in row.cells {
      print(c)
    }
  }
}
```

This prints every cell from every worksheet in the given XLSX file. Please refer to the
[Worksheet model](./Sources/CoreXLSX/Worksheet.swift) for more atttributes you might
need to read from a parsed file.

If you stumble upon a file that can't be parsed, please
[file an issue](https://github.com/MaxDesiatov/CoreXLSX/issues) posting the exact
error message. Thanks to use of standard Swift `Codable` protocol, detailed errors are
generated listing a missing attribute, so it can be easily added to the model enabling 
broader format support.

## Requirements

Xcode 10, Swift 4.2, iOS 9.0 or macOS 10.11

## Installation

### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager/) is a tool for
managing the distribution of Swift code. It’s integrated with the Swift build
system to automate the process of downloading, compiling, and linking
dependencies.

Once you have your Swift package set up, adding `CoreXLSX` as a dependency is as
easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
  .package(url: "https://github.com/MaxDesiatov/CoreXLSX.git", 
           .upToNextMajor(from: "0.2.1"))
]
```

### CocoaPods

CoreXLSX is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CoreXLSX'
```

## Author

[Max Desiatov](https://desiatov.com)

## License

CoreXLSX is available under the Apache 2.0 license. See the [LICENSE.md](./LICENSE.md) file for more info.
