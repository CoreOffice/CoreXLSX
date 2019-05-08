//
//  ViewController.swift
//  CoreXLSX
//
//  Created by Max Desiatov on 11/07/2018.
//  Copyright (c) 2018 Max Desiatov. All rights reserved.
//

import CoreXLSX
import UIKit

class ViewController: UIViewController {
  @IBOutlet var label: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    guard let path = Bundle.main.path(
      forResource: "categories",
      ofType: "xlsx"
    ),
      let file = XLSXFile(filepath: path) else { return }

    do {
      label.text = try "Non-empty cells:\n\n" + file.parseWorksheetPaths()
        .compactMap { try file.parseWorksheet(at: $0) }
        .flatMap { $0.data?.rows ?? [] }
        .flatMap { $0.cells }
        .map { $0.reference.description }
        .joined(separator: " ")
    } catch {
      label.text = error.localizedDescription
    }
  }
}
