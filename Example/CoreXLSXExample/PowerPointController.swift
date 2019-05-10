//
//  PowerPointController.swift
//  CoreXLSXExample
//
//  Created by Max Desiatov on 10/05/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class PowerPointController: UIViewController {
  @IBOutlet var label: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    guard let path = Bundle.main.path(
      forResource: "sample",
      ofType: "pptx"
    ),
      let file = PPTXFile(filepath: path) else { return }

    do {
      label.text = String(describing: try file.parsePresentation())
    } catch {
      label.text = error.localizedDescription
    }
  }
}
