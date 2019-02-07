#  0.4.0 (February 7, 2018)

This a release with API improvements and bug fixes. A big thank you to everyone
who provided the bug reports and contributions that made this release possible!

## Breaking changes

* A few properties on the model type were added with cleaner names and better
fitting types. Most of the old versions of those properties were left as they
were and deprecated, but you might get some breakage with optionality, where we
couldn't find a good deprecation path.

## Additions

* New `parseSharedStrings` function on `XLSXFile` allows you get values of
cells with shared string value. Quite frequently those strings are
unavailable and are only referenced in the original model types you get with
`parseWorksheet`.


* Previously when addressing cells and columns you had to use a stringly-typed
API. It was also not very convenient for specifying a range of columns. This
is now fixed with the new type-safe [`ColumnReference`
struct](https://github.com/MaxDesiatov/CoreXLSX/blob/cf0c7f44e8bf80fdd60fa12b3aa27a15cc79ef86/Tests/CoreXLSXTests/CellReference.swift#L61),
which conforms to `Comparable` and `Strideable`.

* Following the addition of [an error context to
`XMLCoder`](https://github.com/MaxDesiatov/XMLCoder/pull/46), which is the main
dependency of `CoreXLSX`, it is now exposed on `struct XLSXFile`. Pass a
non-zero value to `errorContextLength` argument (default is `0`) of `XLSXFile`
initializer and you'll get a snippet of XML that failed to parse in the debug
description of the error value.

* Additional optional argument `bufferSize` was added to `XLSXFile` initializer as
a response to [previous
reports](https://github.com/MaxDesiatov/CoreXLSX/issues/27) about problems [with
zip file extraction](https://github.com/MaxDesiatov/CoreXLSX/issues/26). The
default value is 10 MiB, which seems to be enough in most cases, but you can
still try passing a larger value for bigger files if you see that an XML file
stops abruptly in the middle of the file. Unfortunately, we haven't found a good
way to adjust this value dynamically based on the file size, but please let us
know if you did.

* Support for Carthage was added as well as support for tvOS and watchOS.

## Bugfixes

Some files that couldn't be previously parsed should now be handled better
thanks to fixes in optionality and more properties added to the model types.

## All changes

* Set global version in project file, bump to 0.4.0 ([#39](https://github.com/MaxDesiatov/CoreXLSX/pull/39))
[@MaxDesiatov](https://github.com/MaxDesiatov)
* Update README.md ([#40](https://github.com/MaxDesiatov/CoreXLSX/pull/40))
[@chriseidhof](https://github.com/chriseidhof)
* Expose `errorContextLength` on `struct XLSXFile` ([#38](https://github.com/MaxDesiatov/CoreXLSX/pull/38))
[@MaxDesiatov](https://github.com/MaxDesiatov)
* Add `customProperties` relationship ([#34](https://github.com/MaxDesiatov/CoreXLSX/pull/34))
[@NSMutableString](https://github.com/NSMutableString)
* Update XMLCoder and ZIPFoundation dependencies ([#36](https://github.com/MaxDesiatov/CoreXLSX/pull/36))
[@MaxDesiatov](https://github.com/MaxDesiatov)
* Update requirements in README.md
[@MaxDesiatov](https://github.com/MaxDesiatov)
* Add extra relationship metadataThumbnail ([#33](https://github.com/MaxDesiatov/CoreXLSX/pull/33))
[@NSMutableString](https://github.com/NSMutableString)
* Refactor Worksheet and Pane values to optional ([#31](https://github.com/MaxDesiatov/CoreXLSX/pull/31))
[@hodovani](https://github.com/hodovani)
* Add bufferSize parameter to init ([#30](https://github.com/MaxDesiatov/CoreXLSX/pull/30))
[@hodovani](https://github.com/hodovani)
* Add more cases to `Relationship.SchemaType` ([#25](https://github.com/MaxDesiatov/CoreXLSX/pull/25))
[@MaxDesiatov](https://github.com/MaxDesiatov)
* Add `public func parseDocumentRelationships` ([#23](https://github.com/MaxDesiatov/CoreXLSX/pull/23))
[@MaxDesiatov](https://github.com/MaxDesiatov)
* Make Relationships public, add parseRelationships ([#22](https://github.com/MaxDesiatov/CoreXLSX/pull/22))
[@MaxDesiatov](https://github.com/MaxDesiatov)
* Add SharedStrings model, parse sharedStrings.xml ([#8](https://github.com/MaxDesiatov/CoreXLSX/pull/8))
[@MaxDesiatov](https://github.com/MaxDesiatov)
* Paste XML snippet into WorksheetTests as is
[@MaxDesiatov](https://github.com/MaxDesiatov)
* Add a second XML snippet to WorksheetTests
[@MaxDesiatov](https://github.com/MaxDesiatov)
* Clarify issue reporting in README.md
[@MaxDesiatov](https://github.com/MaxDesiatov)
* Test newspaces in attributes in WorksheetTests
[@MaxDesiatov](https://github.com/MaxDesiatov)
* More XML with newlines in WorksheetTests
[@MaxDesiatov](https://github.com/MaxDesiatov)
* Add newline characters test to WorksheetTests
[@MaxDesiatov](https://github.com/MaxDesiatov)
* Add cell with a single attribute to WorksheetTests
[@MaxDesiatov](https://github.com/MaxDesiatov)
* Add rows and cells to WorksheetTests
[@MaxDesiatov](https://github.com/MaxDesiatov)
* Update names and types of properties on Worksheet ([#18](https://github.com/MaxDesiatov/CoreXLSX/pull/18))
[@MaxDesiatov](https://github.com/MaxDesiatov)
* Rename sheetData on Worksheet and make it optional ([#17](https://github.com/MaxDesiatov/CoreXLSX/pull/17))
[@MaxDesiatov](https://github.com/MaxDesiatov)
* Add simple `Workbook` model with tests (#16)
[@MaxDesiatov](https://github.com/MaxDesiatov)
* Make `columns` property optional on `Worksheet` ([#14](https://github.com/MaxDesiatov/CoreXLSX/pull/14))
[@MaxDesiatov](https://github.com/MaxDesiatov)
* Fix example project after new files were added ([#13](https://github.com/MaxDesiatov/CoreXLSX/pull/13))
[@MaxDesiatov](https://github.com/MaxDesiatov)
* Remove `worksheetCache` private property as unused ([#11](https://github.com/MaxDesiatov/CoreXLSX/pull/11))
[@MaxDesiatov](https://github.com/MaxDesiatov)
* Clarify platform setting for CocoaPods in README
[@MaxDesiatov](https://github.com/MaxDesiatov)
* Clarify Carthage instructions in README.md
[@MaxDesiatov](https://github.com/MaxDesiatov)
* Add API for filtering cells by rows and columns ([#7](https://github.com/MaxDesiatov/CoreXLSX/pull/7))
[@MaxDesiatov](https://github.com/MaxDesiatov)
* Add Carthage and support for tvOS and watchOS ([#6](https://github.com/MaxDesiatov/CoreXLSX/pull/6))
[@MaxDesiatov](https://github.com/MaxDesiatov)
* Implement `Strideable` on `ColumnReference` ([#5](https://github.com/MaxDesiatov/CoreXLSX/pull/5))
[@MaxDesiatov](https://github.com/MaxDesiatov)
* Add ColumnReference type with new API ([#3](https://github.com/MaxDesiatov/CoreXLSX/pull/3))
[@MaxDesiatov](https://github.com/MaxDesiatov)


#  0.3.0 (November 13, 2018)

* Improve `Worksheet` model property naming ([#2](https://github.com/MaxDesiatov/CoreXLSX/pull/2)).
Some properties on `Worksheet` and its descendants had obscure names, most of that is
fixed now with old names marked as deprecated.

# 0.2.3 (November 12, 2018)

* Refine README.md to include implementation details.

# 0.2.2 (November 11, 2018)

* Refine code comments and links in README.md

# 0.2.1 (November 11, 2018)

* Update README.md with instructions for Swift Package Manager.

# 0.2.0 (November 11, 2018)

* Cell by row/column filtering API with `worksheetCache` ([#1](https://github.com/MaxDesiatov/CoreXLSX/pull/1))
This new API allows users to filter all cells by a row or column reference. To avoid
re-parsing of worksheets, a new private `worksheetCache` property is added on `XLSXFile`.

# 0.1.2 (November 10, 2018)

* Added macOS 10.11 deployment target to the podspec

# 0.1.1 (November 10, 2018)

* Improved README, fixed podspec

# 0.1.0 (November 10, 2018)

* First release with reading support for basic .xlsx files
