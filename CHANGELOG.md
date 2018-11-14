#  0.3.0 (November 13, 2018)

* Improve Worksheet model property naming (#2).
Some properties on Worksheet and its descendants had obscure names, most of that is 
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
