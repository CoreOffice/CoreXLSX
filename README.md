# CoreXLSX

## Excel spreadsheet (XLSX) format support in pure Swift

[![CI Status](https://img.shields.io/travis/MaxDesiatov/CoreXLSX/master.svg?style=flat)](https://travis-ci.org/MaxDesiatov/CoreXLSX)
[![Version](https://img.shields.io/cocoapods/v/CoreXLSX.svg?style=flat)](https://cocoapods.org/pods/CoreXLSX)
[![License](https://img.shields.io/cocoapods/l/CoreXLSX.svg?style=flat)](https://cocoapods.org/pods/CoreXLSX)
[![Platform](https://img.shields.io/cocoapods/p/CoreXLSX.svg?style=flat)](https://cocoapods.org/pods/CoreXLSX)
[![Coverage](https://img.shields.io/codecov/c/github/MaxDesiatov/CoreXLSX/master.svg?style=flat)](https://codecov.io/gh/maxdesiatov/CoreXLSX)

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
model](https://github.com/MaxDesiatov/CoreXLSX/blob/master/Sources/CoreXLSX/Worksheet.swift)
for more atttributes you might need to read from a parsed file.

If you stumble upon a file that can't be parsed, please [file an
issue](https://github.com/MaxDesiatov/CoreXLSX/issues) posting the exact error
message. Thanks to use of standard Swift `Codable` protocol, detailed errors are
generated listing a missing attribute, so it can be easily added to the model
enabling broader format support. Attaching a file that can't be parsed would
also greatly help in diagnosing issues. If these files contain any sensitive
data, we suggest obfuscating or generating fake data with same tools that
generated original files, assuming the issue can still be reproduced this way.

## How does it work?

Since every XLSX file is a zip archive of XML files, `CoreXLSX` uses
[`XMLCoder`](https://github.com/MaxDesiatov/XMLCoder) library and standard
`Codable` protocols to map XML nodes and atrributes into plain Swift structs.
[`ZIPFoundation`](https://www.github.com/weichsel/ZIPFoundation) is used for
in-memory decompression of zip archives. A detailed description is [available
here](https://desiatov.com/swift-codable-xlsx/).

## Requirements

- Xcode 10
- Swift 4.2
- iOS 9.0 / watchOS 2.0 / tvOS 9.0 / macOS 10.11 or later

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
           .upToNextMajor(from: "0.4.0"))
]
```

### CocoaPods

CoreXLSX is available through [CocoaPods](https://cocoapods.org). To install
it, simply add `pod 'CoreXLSX', '~> 0.4.0'` to your `Podfile` like shown here:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
use_frameworks!
target '<Your Target Name>' do
  pod 'CoreXLSX', '~> 0.4.0'
end
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a dependency manager that
builds your dependencies and provides you with binary frameworks.

Carthage can be installed with [Homebrew](https://brew.sh/) using the following
command:

```bash
$ brew update
$ brew install carthage
```

Inside of your `Cartfile`, add GitHub path to `CoreXLSX` `master` branch
(Carthage support is not available in a stable release yet):

```ogdl
github "MaxDesiatov/CoreXLSX" "master"
```

Then, run the following command to build the framework:

```bash
$ carthage update
```

Drag the built frameworks (including the subdependencies `XMLCoder` and
`ZIPFoundation` into your Xcode project.

## Contributing

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
