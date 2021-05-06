# 0.14.1 (6 May 2021)

This is a patch release improving compatibility with different spreadsheet formats.

**Closed issues:**

- Cannot initialize SchemaType from invalid String value `extendedProperties` ([#145](https://github.com/CoreOffice/CoreXLSX/issues/145))
- Cannot initialize SchemaType from invalid String value `workbookmetadata` ([#142](https://github.com/CoreOffice/CoreXLSX/issues/142))

**Merged pull requests:**

- Update dependencies ([#147](https://github.com/CoreOffice/CoreXLSX/pull/147)) via [@ie-ahm-robox](https://github.com/ie-ahm-robox)
- Add `purl.oclc.org` relationship schema type ([#146](https://github.com/CoreOffice/CoreXLSX/pull/146)) via [@MaxDesiatov](https://github.com/MaxDesiatov)
- Add `googleWorkbookMetadata` case to relationships ([#143](https://github.com/CoreOffice/CoreXLSX/pull/143)) via [@MaxDesiatov](https://github.com/MaxDesiatov)
- Add Xcode 12.3 to the `test.yml` workflow ([#144](https://github.com/CoreOffice/CoreXLSX/pull/144)) via [@MaxDesiatov](https://github.com/MaxDesiatov)
- Add Xcode 12.4 to the `test.yml` workflow ([#149](https://github.com/CoreOffice/CoreXLSX/pull/149)) via [@MaxDesiatov](https://github.com/MaxDesiatov)

# 0.14.0 (9 December 2020)

This release improves compatibility with different spreadsheet formats, simplifies cell font and
formatting APIs, and drops support for Carthage. Additionally, Xcode 11.3 on macOS is now the
oldest supported version for building CoreXLSX.

**Breaking changes:**

- Make `parseSharedStrings` return optional value ([#122](https://github.com/CoreOffice/CoreXLSX/pull/122)) via [@MaxDesiatov](https://github.com/MaxDesiatov)
- Test with Xcode 12, drop Carthage and Xcode 10 support ([#140](https://github.com/CoreOffice/CoreXLSX/pull/140)) via [@MaxDesiatov](https://github.com/MaxDesiatov)

**Closed issues:**

- Unable to sort columns by `intValue` ([#137](https://github.com/CoreOffice/CoreXLSX/issues/137))
- Cannot initialize SchemaType from invalid String value ([#136](https://github.com/CoreOffice/CoreXLSX/issues/136))
- Odd cell.s value ([#134](https://github.com/CoreOffice/CoreXLSX/issues/134))
- 0.13.0 not available on Cocoapods ([#133](https://github.com/CoreOffice/CoreXLSX/issues/133))
- Unable to read xlsx file ([#130](https://github.com/CoreOffice/CoreXLSX/issues/130))
- Increase speed of parsing? ([#127](https://github.com/CoreOffice/CoreXLSX/issues/127))
- .xlsx File not opening with XLSXFile() ([#125](https://github.com/CoreOffice/CoreXLSX/issues/125))
- Getting Data From a specific Worksheet ([#124](https://github.com/CoreOffice/CoreXLSX/issues/124))
- ArchiveEntryNotFound error ([#121](https://github.com/CoreOffice/CoreXLSX/issues/121))
- Printing an empty cell? ([#118](https://github.com/CoreOffice/CoreXLSX/issues/118))
- Handling encrypted spreadsheets? ([#101](https://github.com/CoreOffice/CoreXLSX/issues/101))

**Merged pull requests:**

- Compare `ColumnReference` by `intValue` ([#139](https://github.com/CoreOffice/CoreXLSX/pull/139)) via [@MaxDesiatov](https://github.com/MaxDesiatov)
- Add missing `SchemaType.webExtensionTaskPanes` ([#138](https://github.com/CoreOffice/CoreXLSX/pull/138)) via [@MaxDesiatov](https://github.com/MaxDesiatov)
- Add `font(in:)` and `format(in:)` functions ([#135](https://github.com/CoreOffice/CoreXLSX/pull/135)) via [@MaxDesiatov](https://github.com/MaxDesiatov)
- Test with Swift 5.3 for Linux ([#132](https://github.com/CoreOffice/CoreXLSX/pull/132)) via [@MaxDesiatov](https://github.com/MaxDesiatov)
- Generate and publish docs with `swift-doc` ([#131](https://github.com/CoreOffice/CoreXLSX/pull/131)) via [@MaxDesiatov](https://github.com/MaxDesiatov)
- Add “person” to the relationship types ([#126](https://github.com/CoreOffice/CoreXLSX/pull/126)) via [@texuf](https://github.com/texuf)
- Fix parsing root relationships worksheet paths ([#123](https://github.com/CoreOffice/CoreXLSX/pull/123)) via [@MaxDesiatov](https://github.com/MaxDesiatov)

# 0.13.0 (8 July 2020)

This is a bugfix release with breaking changes that make `count` property on `MergeCells` and all
properties on `Workbook.View` optional. Many thanks to
[@Ethan-Chew](https://github.com/Ethan-Chew) and
[@robgtsoftware](https://github.com/robgtsoftware) for reporting these issues!

**Closed issues:**

- Printing Strings in a Column ([#116](https://github.com/CoreOffice/CoreXLSX/issues/116))
- File.parseWorksheet(at: path) dies ([#94](https://github.com/CoreOffice/CoreXLSX/issues/94))

**Merged pull requests:**

- Make Workbook.View properties optional ([#120](https://github.com/CoreOffice/CoreXLSX/pull/120))
  via [@MaxDesiatov](https://github.com/MaxDesiatov)
- Make count optional in MergeCells ([#119](https://github.com/CoreOffice/CoreXLSX/pull/119)) via
  [@MaxDesiatov](https://github.com/MaxDesiatov)

# 0.12.0 (26 June 2020)

The is a bugfix release with a breaking change, it makes `size` and `font` properties
optional on the `RichText.Properties` type to improve compatibility with certain spreadsheets.
Thanks to [@Ethan-Chew](https://github.com/Ethan-Chew) for reporting this in
[#116](https://github.com/CoreOffice/CoreXLSX/issues/116).

# 0.11.1 (12 June 2020)

This is a bugfix release that resolves an issue with parsing cells that contain time
values. Thanks to [@mb812](https://github.com/mb812) for reporting it!

**Closed issues:**

- Error parsing cells with Time value ([#114](https://github.com/CoreOffice/CoreXLSX/issues/114))
- `file.parseWorksheetPathsAndNames()` wanna `workbook: <#Workbook#>` ([#113](https://github.com/CoreOffice/CoreXLSX/issues/113))
- XLSXFile not initialising when passing document directory path ([#108](https://github.com/CoreOffice/CoreXLSX/issues/108))

**Merged pull requests:**

- Fix time values returned by Cell.dateValue ([#115](https://github.com/CoreOffice/CoreXLSX/pull/115)) via [@MaxDesiatov](https://github.com/MaxDesiatov)

# 0.11.0 (30 May 2020)

This is a feature release that enables compatibility with [CryptoOffice](https://github.com/CoreOffice/CryptoOffice) for decrypting spreadsheets. Additionally, with 0.11.0 you can easily get worksheet names with a new `parseWorksheetPathsAndNames` function on `XLSXFile` and get rich text values from cells with a new `richStringValue` function on `Cell`.

Due to technical issues, Swift 5.0 CI job for Linux has been removed, so compatibility with Swift 5.0 on Linux can no longer be guaranteed. While CoreXLSX may continue to work with Swift 5.0 on Linux, please update to Swift 5.1 or later to avoid unexpected issues.

Thanks to [@kobylyanets](https://github.com/kobylyanets) and
[@duodo2412](https://github.com/duodo2412) for their contributions to this release!

**New APIs:**

- `XLSXFile` now provides a new initializer that takes an argument of `Data` type. This allows opening in-memory documents, the primary example being spreadsheets decrypted with [CryptoOffice](https://github.com/CoreOffice/CryptoOffice).

- `XLSXFile` now has a new `parseWorksheetPathsAndNames` function that returns an array of
  worksheet names and their paths in a given workbook, while previously you had to use
  `parseWorksheetPaths` and match paths manually with results of the `parseWorkbooks` function.

- `Cell` now has a `richStringValue` function that takes a result of
  `XLSXFile.parseSharedStrings` function and produces an array of `RichText` values. This
  makes it easier to query rich text content from cells, while previously you had to match
  cell values against `SharedStrings` manually.

**Breaking change:**

Due to the introduction of the new `XLSXFile.init(data:)` initializer, the `filepath`
property on `XLSXFile` no longer makes sense. This property was not used internally
in any way and in-memory files don't have any filepaths. If you need to refer to a
filepath of an `.xlsx` file after you've parsed from your filesystem, you should
retain it manually and process it separately as you see fit.

**Closed issues:**

- API for matching sheet names to sheet paths ([#105](https://github.com/CoreOffice/CoreXLSX/issues/105))

**Merged pull requests:**

- Bump XMLCoder dependency to 0.11.1 ([#112](https://github.com/CoreOffice/CoreXLSX/pull/112)) via [@MaxDesiatov](https://github.com/MaxDesiatov)
- Add data XLSXFile.init, remove filepath property ([#111](https://github.com/CoreOffice/CoreXLSX/pull/111)) via [@MaxDesiatov](https://github.com/MaxDesiatov)
- Add func parseWorksheetPathsAndNames on XLSXFile ([#109](https://github.com/CoreOffice/CoreXLSX/pull/109)) via [@MaxDesiatov](https://github.com/MaxDesiatov)
- Drop support for Swift 5.0 on Linux ([#110](https://github.com/CoreOffice/CoreXLSX/pull/110)) via [@MaxDesiatov](https://github.com/MaxDesiatov)
- Add ability to get cell value as RichText ([#106](https://github.com/CoreOffice/CoreXLSX/pull/106)) via [@kobylyanets](https://github.com/kobylyanets)

# 0.10.0 (6 April 2020)

This is a release with bugfixes and a few improvements to usability of
the spreadsheet cell values API. Thanks to all contributors and users, you
provide an invaluable amount of feedback and help!

**New API:**

The library now provides a simplified API to fetch string
and date values from cells, which is much easier to use than the previous
version (which is still available).

Here's how you can get all strings (including shared strings) in column "C"
for example:

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

**Breaking change:**

The `type` property on `Cell` is no longer of `String` type. It was previously
used to check if cell's type is equal to `"s"`, which denoted a shared string.
You should use enum values for that since this release, which for shared strings
now is (unsurprisingly) `.sharedString`.

**Closed issues:**

- Xcode 11 installation and build ([#90](https://github.com/MaxDesiatov/CoreXLSX/issues/90))
- Reading Date values from cell ([#89](https://github.com/MaxDesiatov/CoreXLSX/issues/89))
- Can't open xml ([#82](https://github.com/MaxDesiatov/CoreXLSX/issues/82))
- Not able to read Numeric data from Sheet ([#81](https://github.com/MaxDesiatov/CoreXLSX/issues/81))
- Getting the value of a cell with number format? ([#71](https://github.com/MaxDesiatov/CoreXLSX/issues/71))
- Opening xlsx file Document Directory, Crashes ([#52](https://github.com/MaxDesiatov/CoreXLSX/issues/52))

**Merged pull requests:**

- officeDocument is misspelled in corePropreties Relationship ([#95](https://github.com/MaxDesiatov/CoreXLSX/pull/95)) via [@mrkammoun](https://github.com/mrkammoun)
- Add cell type enum, date/sharedStrings helpers ([#102](https://github.com/MaxDesiatov/CoreXLSX/pull/102)) via [@MaxDesiatov](https://github.com/MaxDesiatov)
- Make XLSXFile a class, not a struct ([#100](https://github.com/MaxDesiatov/CoreXLSX/pull/100)) via [@MaxDesiatov](https://github.com/MaxDesiatov)
- Clarify lack of support for .xls files in README ([#99](https://github.com/MaxDesiatov/CoreXLSX/pull/99)) via [@MaxDesiatov](https://github.com/MaxDesiatov)
- Clarify Xcode 11 and Xcode 10 project details ([#98](https://github.com/MaxDesiatov/CoreXLSX/pull/98)) via [@MaxDesiatov](https://github.com/MaxDesiatov)
- Update dependencies to their latest versions ([#96](https://github.com/MaxDesiatov/CoreXLSX/pull/96)) via [@MaxDesiatov](https://github.com/MaxDesiatov)
- Update SwiftFormat settings, add pre-commit ([#97](https://github.com/MaxDesiatov/CoreXLSX/pull/97)) via [@MaxDesiatov](https://github.com/MaxDesiatov)
- Fix workbooks with no views, cleanup tests ([#93](https://github.com/MaxDesiatov/CoreXLSX/pull/93)) via [@MaxDesiatov](https://github.com/MaxDesiatov)
- Test on Xcode 11.3 with macOS 10.15 ([#92](https://github.com/MaxDesiatov/CoreXLSX/pull/92)) via [@MaxDesiatov](https://github.com/MaxDesiatov)
- Update ZIPFoundation to 0.9.10 ([#91](https://github.com/MaxDesiatov/CoreXLSX/pull/91)) via [@MaxDesiatov](https://github.com/MaxDesiatov)

# 0.9.1 (8 November 2019)

This release adds a new value to the `Relationship.SchemaType` enum, which fixes
compatibility with some spreadsheet files. Thanks to
[@mxcl](https://github.com/mxcl) for the bug report!

**Fixed bugs:**

- Cannot initialize SchemaType from invalid String value
  [\#87](https://github.com/MaxDesiatov/CoreXLSX/issues/87)

**Merged pull requests:**

- Add `case customXml` to Relationship.SchemaType
  [\#88](https://github.com/MaxDesiatov/CoreXLSX/pull/88)
  ([MaxDesiatov](https://github.com/MaxDesiatov))

# 0.9.0 (19 October 2019)

This release adds Linux support and improves compatibility with `.xlsx` files
that contain shared strings. Thanks to
[@CloseServer](https://github.com/CloseServer),
[@funnel20](https://github.com/funnel20) and
[@LiewLi](https://github.com/LiewLi) for bug reports and contributions!

**Implemented enhancements:**

- Bump XMLCoder to 0.9.0, add CI jobs for Linux, Xcode 11
  [\#86](https://github.com/MaxDesiatov/CoreXLSX/pull/86)
  ([MaxDesiatov](https://github.com/MaxDesiatov))

**Fixed bugs:**

- Multi-line text in an Excel cell is parsed into single line in the
  SharedStrings property `text`
  [\#83](https://github.com/MaxDesiatov/CoreXLSX/issues/83)

**Closed issues:**

- I crashed while calling try file.parsesharedstrings \(\) with an error
  [\#79](https://github.com/MaxDesiatov/CoreXLSX/issues/79)

**Merged pull requests:**

- Bump line length limit in .swiftlint.yml
  [\#85](https://github.com/MaxDesiatov/CoreXLSX/pull/85)
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Make decoder.trimValueWhitespaces false, add test
  [\#84](https://github.com/MaxDesiatov/CoreXLSX/pull/84)
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Bump XMLCoder dependency to 0.8.0
  [\#80](https://github.com/MaxDesiatov/CoreXLSX/pull/80)
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- SharedString uniqueCount property can be nil
  [\#78](https://github.com/MaxDesiatov/CoreXLSX/pull/78)
  ([LiewLi](https://github.com/LiewLi))

# 0.8.0 (12 July 2019)

Feature and bugfix release that makes the library compatible with more
spreadsheet types. It also adds support for [`Comments`
structure](https://github.com/MaxDesiatov/CoreXLSX/blob/master/Sources/CoreXLSX/Comments.swift),
which can be parsed with the new [`parseComments`
API](https://github.com/MaxDesiatov/CoreXLSX/blob/b7b802afeff0da438ffa7750176769ceef1f877d/Sources/CoreXLSX/CoreXLSX.swift#L123).

Many thanks to [@grin](https://github.com/grin),
[@GoldenJoe](https://github.com/GoldenJoe) and
[@LiewLi](https://github.com/LiewLi) for reporting and fixing issues in this
release.

**Closed issues:**

- `parseDocumentPaths` has internal protection, but is needed by
  `parseDocumentRelationships`
  [\#74](https://github.com/MaxDesiatov/CoreXLSX/issues/74)
- Missing Documentation
  [\#73](https://github.com/MaxDesiatov/CoreXLSX/issues/73)

**Merged pull requests:**

- Bump XMLCoder dependency to 0.7.0
  [\#77](https://github.com/MaxDesiatov/CoreXLSX/pull/77)
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Fix non-macOS framework targets
  [\#76](https://github.com/MaxDesiatov/CoreXLSX/pull/76)
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- missing `text` property when format is applied at the character level
  [\#72](https://github.com/MaxDesiatov/CoreXLSX/pull/72)
  ([LiewLi](https://github.com/LiewLi))
- Add comment support [\#70](https://github.com/MaxDesiatov/CoreXLSX/pull/70)
  ([grin](https://github.com/grin))

# 0.7.0 (25 May 2019)

Bugfix release that improves compatibility with different spreadsheet types.

Thanks to [@grin](https://github.com/grin) for reporting and fixing issues in
this release.

**Breaking changes:**

All properties on `struct Format` except `fontId` and `numberFormatId` are
now optional.

**Additions:**

New `borderId` and `fillId` properties on `struct Format`.

**Fixed bugs:**

- Can't get cell string [\#58](https://github.com/MaxDesiatov/CoreXLSX/issues/58)
- Can't load basic spreadsheets created in Google Docs [\#64](https://github.com/MaxDesiatov/CoreXLSX/issues/64)
- `fillId` and `borderId` attributes missing from CoreXLSX.Format [\#65](https://github.com/MaxDesiatov/CoreXLSX/issues/65)

**Merged pull requests:**

- Fix decoding of Borders model type [\#69](https://github.com/MaxDesiatov/CoreXLSX/pull/69) ([MaxDesiatov](https://github.com/MaxDesiatov))
- Add fail flag to scripts [\#68](https://github.com/MaxDesiatov/CoreXLSX/pull/68) ([hodovani](https://github.com/hodovani))
- Move from Travis to Azure Pipelines [\#67](https://github.com/MaxDesiatov/CoreXLSX/pull/67) ([MaxDesiatov](https://github.com/MaxDesiatov))
- Add missing attributes [\#66](https://github.com/MaxDesiatov/CoreXLSX/pull/66) ([grin](https://github.com/grin))

# 0.6.1 (9 May 2019)

Bugfix release that adds `case externalLink` to `Relationship.SchemaType`
improving .xlsx compatibility.

# 0.6.0 (2 May 2019)

This is a bugfix release with changes to the model API that improve
compatibility with files containing formulas and varied shared string formats.

Specifically:

- new `struct Formula` added with a corresponding property on `struct Cell`
- property `color` on `struct Properties` became optional
- `properties` on `struct RichText` became optional
- new `chartsheet` case added to `enum Relationship`
- `richText` on `struct SharedStrings` became an array, not optional

**Closed issues:**

- Error Domain=NSCocoaErrorDomain Code=4865 "Expected String but found null
  instead." [\#59](https://github.com/MaxDesiatov/CoreXLSX/issues/59)
- Importing XLSX file [\#56](https://github.com/MaxDesiatov/CoreXLSX/issues/56)
- Error ParseCellContent
  [\#51](https://github.com/MaxDesiatov/CoreXLSX/issues/51)
- error `parseWorksheet`
  [\#50](https://github.com/MaxDesiatov/CoreXLSX/issues/50)
- Couldn't find end of Start Tag c
  [\#37](https://github.com/MaxDesiatov/CoreXLSX/issues/37)

**Merged pull requests:**

- Add `Formula` struct, fix other model types
  [\#61](https://github.com/MaxDesiatov/CoreXLSX/pull/61)
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Bump `XMLCoder` dependency to 0.5, fix `SharedStrings`
  [\#60](https://github.com/MaxDesiatov/CoreXLSX/pull/60)
  ([MaxDesiatov](https://github.com/MaxDesiatov))

# 0.5.0 (18 April 2019)

This is a release with API additions and bug fixes.

This release of CoreXLSX can be integrated as a Swift 5 module if you're using
Xcode 10.2, but support for Swift 4.2 and earlier Xcode 10 versions is also
maintained.

Compatibility is improved for big files and files that internally contain
namespaced XML. A few other previously reported compatibility issues are now
fixed. Many thanks to everyone who reported the issues, the improvements in this
release wouldn't be possible without your contribution!

**Breaking changes:**

Several properties on the model types became optional when there's no
guarantee they are always available in files generated by different apps and
tools.

**Additions:**

Now you can parse style information from the archive with the new
`parseStyles()` function. Please refer to the [`Styles`
model](https://github.com/MaxDesiatov/CoreXLSX/blob/master/Sources/CoreXLSX/Styles.swift)
for more details. Please note that not all XLSX files contain style
information, so you should be prepared to handle the errors thrown from
`parseStyles()` function in that case.

**Merged pull requests:**

- Add testSpacePreserve to SharedStrings tests [\#57](https://github.com/MaxDesiatov/CoreXLSX/pull/57) ([MaxDesiatov](https://github.com/MaxDesiatov))
- Fix XML namespaces, bump ZIPFoundation dependency [\#55](https://github.com/MaxDesiatov/CoreXLSX/pull/55) ([MaxDesiatov](https://github.com/MaxDesiatov))
- Split package manifest for Swift 5 and Swift 4.2 [\#54](https://github.com/MaxDesiatov/CoreXLSX/pull/54) ([MaxDesiatov](https://github.com/MaxDesiatov))
- Update XMLCoder dependency to 0.4.0 [\#53](https://github.com/MaxDesiatov/CoreXLSX/pull/53) ([MaxDesiatov](https://github.com/MaxDesiatov))
- Add Styles with structs describing styles.xml [\#46](https://github.com/MaxDesiatov/CoreXLSX/pull/46) ([MaxDesiatov](https://github.com/MaxDesiatov))
- Add test to check sharedStrings order [\#44](https://github.com/MaxDesiatov/CoreXLSX/pull/44) ([hodovani](https://github.com/hodovani))
- Fix root paths in CoreXLSX, fix formatter & linter [\#43](https://github.com/MaxDesiatov/CoreXLSX/pull/43) ([MaxDesiatov](https://github.com/MaxDesiatov))

# 0.4.0 (7 February 2019)

This is a release with API improvements and bug fixes. A big thank you to everyone
who provided bug reports and contributions that made this release possible!

**Breaking changes:**

- A few properties on the model types were added with cleaner names and better
  fitting types. Most of the old versions of those properties were kept as
  deprecated, but you might get some breakage with optionality, where we
  couldn't find a good deprecation path.

**Additions:**

- New `parseSharedStrings` function on `XLSXFile` allows you get values of
  cells with shared string value. Quite frequently those strings are
  unavailable and are only referenced in the original model types you get with
  `parseWorksheet`.

- Previously when addressing cells and columns you had to use a stringly-typed
  API. It was also not very convenient for specifying a range of columns. This
  is now fixed with the new type-safe [`ColumnReference`
  struct](https://github.com/MaxDesiatov/CoreXLSX/blob/cf0c7f44e8bf80fdd60fa12b3aa27a15cc79ef86/Tests/CoreXLSXTests/CellReference.swift#L61),
  which conforms to `Comparable` and `Strideable`.

- Following the addition of [an error context to
  `XMLCoder`](https://github.com/MaxDesiatov/XMLCoder/pull/46), which is the main
  dependency of `CoreXLSX`, it is now exposed on `struct XLSXFile`. Pass a
  non-zero value to `errorContextLength` argument (default is `0`) of `XLSXFile`
  initializer and you'll get a snippet of XML that failed to parse in the debug
  description of the error value.

- Additional optional argument `bufferSize` was added to `XLSXFile` initializer as
  a response to [previous
  reports](https://github.com/MaxDesiatov/CoreXLSX/issues/27) about problems [with
  zip file extraction](https://github.com/MaxDesiatov/CoreXLSX/issues/26). The
  default value is 10 MiB, which seems to be enough in most cases, but you can
  still try passing a larger value for bigger files if you see that an XML file
  stops abruptly in the middle of the file. Unfortunately, we haven't found a good
  way to adjust this value dynamically based on the file size, but a sufficiently
  large value should work for all files, which is the default.

- Support for Carthage was added as well as support for tvOS and watchOS.

**Bugfixes:**

Some files that couldn't be previously parsed should now be handled better
thanks to fixes in optionality and more properties added to the model types.

**All changes:**

- Set global version in project file, bump to 0.4.0 ([#39](https://github.com/MaxDesiatov/CoreXLSX/pull/39))
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Update README.md ([#40](https://github.com/MaxDesiatov/CoreXLSX/pull/40))
  [@chriseidhof](https://github.com/chriseidhof)
- Expose `errorContextLength` on `struct XLSXFile` ([#38](https://github.com/MaxDesiatov/CoreXLSX/pull/38))
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Add `customProperties` relationship ([#34](https://github.com/MaxDesiatov/CoreXLSX/pull/34))
  ([NSMutableString](https://github.com/NSMutableString))
- Update XMLCoder and ZIPFoundation dependencies ([#36](https://github.com/MaxDesiatov/CoreXLSX/pull/36))
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Update requirements in README.md
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Add extra relationship metadataThumbnail ([#33](https://github.com/MaxDesiatov/CoreXLSX/pull/33))
  ([NSMutableString](https://github.com/NSMutableString))
- Refactor Worksheet and Pane values to optional ([#31](https://github.com/MaxDesiatov/CoreXLSX/pull/31))
  ([hodovani](https://github.com/hodovani))
- Add bufferSize parameter to init ([#30](https://github.com/MaxDesiatov/CoreXLSX/pull/30))
  ([hodovani](https://github.com/hodovani))
- Add more cases to `Relationship.SchemaType` ([#25](https://github.com/MaxDesiatov/CoreXLSX/pull/25))
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Add `public func parseDocumentRelationships` ([#23](https://github.com/MaxDesiatov/CoreXLSX/pull/23))
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Make Relationships public, add parseRelationships ([#22](https://github.com/MaxDesiatov/CoreXLSX/pull/22))
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Add SharedStrings model, parse sharedStrings.xml ([#8](https://github.com/MaxDesiatov/CoreXLSX/pull/8))
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Paste XML snippet into WorksheetTests as is
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Add a second XML snippet to WorksheetTests
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Clarify issue reporting in README.md
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Test newspaces in attributes in WorksheetTests
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- More XML with newlines in WorksheetTests
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Add newline characters test to WorksheetTests
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Add cell with a single attribute to WorksheetTests
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Add rows and cells to WorksheetTests
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Update names and types of properties on Worksheet ([#18](https://github.com/MaxDesiatov/CoreXLSX/pull/18))
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Rename sheetData on Worksheet and make it optional ([#17](https://github.com/MaxDesiatov/CoreXLSX/pull/17))
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Add simple `Workbook` model with tests (#16)
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Make `columns` property optional on `Worksheet` ([#14](https://github.com/MaxDesiatov/CoreXLSX/pull/14))
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Fix example project after new files were added ([#13](https://github.com/MaxDesiatov/CoreXLSX/pull/13))
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Remove `worksheetCache` private property as unused ([#11](https://github.com/MaxDesiatov/CoreXLSX/pull/11))
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Clarify platform setting for CocoaPods in README
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Clarify Carthage instructions in README.md
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Add API for filtering cells by rows and columns ([#7](https://github.com/MaxDesiatov/CoreXLSX/pull/7))
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Add Carthage and support for tvOS and watchOS ([#6](https://github.com/MaxDesiatov/CoreXLSX/pull/6))
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Implement `Strideable` on `ColumnReference` ([#5](https://github.com/MaxDesiatov/CoreXLSX/pull/5))
  ([MaxDesiatov](https://github.com/MaxDesiatov))
- Add ColumnReference type with new API ([#3](https://github.com/MaxDesiatov/CoreXLSX/pull/3))
  ([MaxDesiatov](https://github.com/MaxDesiatov))

# 0.3.0 (13 November 2018)

- Improve `Worksheet` model property naming ([#2](https://github.com/MaxDesiatov/CoreXLSX/pull/2)).
  Some properties on `Worksheet` and its descendants had obscure names, most of that is
  fixed now with old names marked as deprecated.

# 0.2.3 (12 November 2018)

- Refine README.md to include implementation details.

# 0.2.2 (11 November 2018)

- Refine code comments and links in README.md

# 0.2.1 (11 November 2018)

- Update README.md with instructions for Swift Package Manager.

# 0.2.0 (11 November 2018)

- Cell by row/column filtering API with `worksheetCache` ([#1](https://github.com/MaxDesiatov/CoreXLSX/pull/1))
  This new API allows users to filter all cells by a row or column reference. To avoid
  re-parsing of worksheets, a new private `worksheetCache` property is added on `XLSXFile`.

# 0.1.2 (10 November 2018)

- Added macOS 10.11 deployment target to the podspec

# 0.1.1 (10 November 2018)

- Improved README, fixed podspec

# 0.1.0 (10 November 2018)

- First release with reading support for basic .xlsx files
