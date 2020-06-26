# CoreXLSX

## Excel spreadsheet (XLSX) format parser written in pure Swift

[![Build Status](https://dev.azure.com/CoreOffice/CoreOffice/_apis/build/status/CoreOffice.CoreXLSX?branchName=main)](https://dev.azure.com/CoreOffice/CoreOffice/_build/latest?definitionId=1&branchName=main)
[![Version](https://img.shields.io/cocoapods/v/CoreXLSX.svg?style=flat)](https://cocoapods.org/pods/CoreXLSX)
[![License](https://img.shields.io/cocoapods/l/CoreXLSX.svg?style=flat)](https://cocoapods.org/pods/CoreXLSX)
![Platform](https://img.shields.io/badge/platform-watchos%20%7C%20ios%20%7C%20tvos%20%7C%20macos%20%7C%20linux-lightgrey.svg?style=flat)
[![Coverage](https://img.shields.io/codecov/c/github/CoreOffice/CoreXLSX/main.svg?style=flat)](https://codecov.io/gh/CoreOffice/CoreXLSX)

CoreXLSX is a library focused on representing the low-level structure
of [the XML-based XLSX spreadsheet
format](https://en.wikipedia.org/wiki/Office_Open_XML). It allows you to open a
spreadsheet archive with `.xlsx` extension and map its internal structure into
model types expressed directly in Swift.

Important to note that this library provides read-only support only for [the `.xlsx`
format](https://en.wikipedia.org/wiki/Office_Open_XML). As the older
[legacy `.xls` spreadsheet
format](https://en.wikipedia.org/wiki/Microsoft_Excel#File_formats)
has completely different internals, please refer to [other
libraries](https://github.com/libxls/libxls) if you need to work with files of
that type.

If your `.xlsx` files use [ECMA-376 agile
encryption](https://docs.microsoft.com/en-us/openspecs/office_file_formats/ms-offcrypto/cab78f5c-9c17-495e-bea9-032c63f02ad8) (which seems to be the most popular variety), have a look at the
[CryptoOffice](https://github.com/CoreOffice/CryptoOffice) library.

## Example

To run the example project, clone the repo, and run `pod install` from the
Example directory first.

Model types in `CoreXLSX` directly map internal structure of XLSX format with
more sensible naming applied to a few attributes. The API is pretty simple:

```swift
import CoreXLSX

let filepath = "./categories.xlsx"
guard let file = XLSXFile(filepath: filepath) else {
  fatalError("XLSX file at \(filepath) is corrupted or does not exist")
}

for wbk in try file.parseWorkbooks() {
  for (name, path) in try file.parseWorksheetPathsAndNames(workbook: wbk) {
    if let worksheetName = name {
      print("This worksheet has a name: \(worksheetName)")
    }

    let worksheet = try file.parseWorksheet(at: path)
    for row in worksheet.data?.rows ?? [] {
      for c in row.cells {
        print(c)
      }
    }
  }
}
```

This prints raw cell data from every worksheet in the given XLSX file. Please refer
to the [`Worksheet`
model](https://github.com/CoreOffice/CoreXLSX/blob/main/Sources/CoreXLSX/Worksheet/Worksheet.swift)
for more atttributes you might need to read from a parsed file.

Strings in spreadsheet internals are frequently represented as strings
shared between multiple worksheets, thus to parse a string value from a cell
use of `stringValue(_: SharedStrings)` function is recommended together with
`try file.parseSharedString()`.

Here's how you can get all strings in column "C" for example:

```swift
let sharedStrings = try file.parseSharedStrings()
let columnCStrings = worksheet.cells(atColumns: [ColumnReference("C")!])
  .compactMap { $0.stringValue(sharedStrings) }
```

To parse a date value from a cell, use `dateValue` property on the `Cell` type:

```swift
let columnCDates = worksheet.cells(atColumns: [ColumnReference("C")!])
  .compactMap { $0.dateValue }
```

Similarly, to parse rich strings, use the `richStringValue` function:

```swift
let richStrings = try file.parseSharedStrings()
let columnCRichStrings = worksheet.cells(atColumns: [ColumnReference("C")!])
  .compactMap { $0.richStringValue(sharedStrings) }
```

### Styles

Since version 0.5.0 you can parse style information from the archive with the
new `parseStyles()` function. Please refer to the [`Styles`
model](https://github.com/CoreOffice/CoreXLSX/blob/main/Sources/CoreXLSX/Styles.swift)
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
issue](https://github.com/CoreOffice/CoreXLSX/issues) posting the exact error
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

- Ubuntu 16.04 or later
- Swift 5.1 or later

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
  .package(url: "https://github.com/CoreOffice/CoreXLSX.git",
           .upToNextMinor(from: "0.12.0"))
]
```

If you're using CoreXLSX in an app built with Xcode, you can also add it as a direct
dependency [using Xcode's
GUI](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app).

### CocoaPods

CoreXLSX is available through [CocoaPods](https://cocoapods.org) on Apple's
platforms. To install it, simply add `pod 'CoreXLSX', '~> 0.12.0'` to your
`Podfile` like shown here:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
use_frameworks!
target '<Your Target Name>' do
  pod 'CoreXLSX', '~> 0.12.0'
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
github "CoreOffice/CoreXLSX" ~> 0.12.0
```

Then, run the following command to build the framework:

```bash
$ carthage update
```

Drag the built frameworks (including the subdependencies `XMLCoder` and
`ZIPFoundation`) into your Xcode project.

## Contributing

### Sponsorship

If this library saved you any amount of time or money, please consider [sponsoring
the work of its maintainer](https://github.com/sponsors/MaxDesiatov). While some of the
sponsorship tiers give you priority support or even consulting time, any amount is
appreciated and helps in maintaining the project.

### Development Workflow

On macOS the easiest way to start working on the project is to open the
`Package.swift` file in Xcode 11. There is an extensive test suite that both
tests files end-to-end and isolated snippets against their corresponding model
values.

If Xcode 11 is not available for you and you'd like to develop the library
or to run the test suite in Xcode 10, you need to run
`carthage bootstrap` in the root directory of the cloned repository first.
Please refer to [the Carthage installation instructions](#carthage) described
in the section above if you don't have Carthage installed.
Then you can open the `CoreXLSX.xcodeproj` from the same directory and select
the `CoreXLSXmacOS` scheme. This is the only scheme that has the tests
set up, but you can also build any other scheme (e.g. `CoreXLSXiOS`) to make
sure it builds on other platforms.

If you prefer not to work with Xcode, the project fully supports SwiftPM and the
usual workflow with `swift build` and `swift test` should work, otherwise please
[report this as a bug](https://github.com/CoreOffice/CoreXLSX/issues/new).

### Coding Style

This project uses [SwiftFormat](https://github.com/nicklockwood/SwiftFormat)
and [SwiftLint](https://github.com/realm/SwiftLint) to
enforce formatting and coding style. We encourage you to run SwiftFormat within
a local clone of the repository in whatever way works best for you either
manually or automatically via an [Xcode
extension](https://github.com/nicklockwood/SwiftFormat#xcode-source-editor-extension),
[build phase](https://github.com/nicklockwood/SwiftFormat#xcode-build-phase) or
[git pre-commit
hook](https://github.com/nicklockwood/SwiftFormat#git-pre-commit-hook) etc.

To guarantee that these tools run before you commit your changes on macOS, you're encouraged
to run this once to set up the [pre-commit](https://pre-commit.com/) hook:

```
brew bundle # installs SwiftLint, SwiftFormat and pre-commit
pre-commit install # installs pre-commit hook to run checks before you commit
```

Refer to [the pre-commit documentation page](https://pre-commit.com/) for more details
and installation instructions for other platforms.

SwiftFormat and SwiftLint also run on CI for every PR and thus a CI build can
fail with inconsistent formatting or style. We require CI builds to pass for all
PRs before merging.

### Code of Conduct

This project adheres to the [Contributor Covenant Code of
Conduct](https://github.com/CoreOffice/CoreXLSX/blob/main/CODE_OF_CONDUCT.md).
By participating, you are expected to uphold this code. Please report
unacceptable behavior to conduct@coreoffice.org.

## Maintainers

[Max Desiatov](https://desiatov.com), [Matvii Hodovaniuk](https://matvii.hodovani.uk).

## License

CoreXLSX is available under the Apache 2.0 license. See the
[LICENSE](https://github.com/CoreOffice/CoreXLSX/blob/main/LICENSE.md) file
for more info.
