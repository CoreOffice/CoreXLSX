//
//  CellQueries.swift
//  CoreXLSXmacOS
//
//  Created by Max Desiatov on 24/11/2018.
//

extension Worksheet {
  /// Return all cells that are contained in a given worksheet and collection of
  /// columns.
  public func cells<T>(atColumns columns: T) -> [Cell]
    where T: Collection, T.Element == ColumnReference {
    return data?.rows.map {
      $0.cells.filter { columns.contains($0.reference.column) }
    }
    .reduce([]) { $0 + $1 } ?? []
  }

  /// Return all cells that are contained in a given worksheet and collection of
  /// rows.
  public func cells<T>(atRows rows: T) -> [Cell]
    where T: Collection, T.Element == UInt {
    return data?.rows.filter { rows.contains($0.reference) }
      .reduce([]) { $0 + $1.cells } ?? []
  }

  /// Return all cells that are contained in a given worksheet and collections
  /// of rows and columns.
  public func cells<T1, T2>(atColumns columns: T1, rows: T2) -> [Cell]
    where T1: Collection, T1.Element == ColumnReference,
    T2: Collection, T2.Element == UInt {
    return data?.rows.filter { rows.contains($0.reference) }.map {
      $0.cells.filter { columns.contains($0.reference.column) }
    }
    .reduce([]) { $0 + $1 } ?? []
  }
}
