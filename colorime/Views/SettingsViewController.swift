//
//  SettingsViewController.swift
//  colorime
//
//  Created by raaowx on 19/11/20.
//

import UIKit

class SettingsViewController: UIViewController {
  @IBOutlet weak var timeHexFormatV: UIView!
  @IBOutlet weak var dateShowV: UIView!
  @IBOutlet weak var dateHexFormatSV: UIStackView!
  @IBOutlet weak var dateHexFormatV: UIView!
  @IBOutlet weak var screenKeepActiveV: UIView!

  override func viewDidLoad() {
    super.viewDidLoad()
    timeHexFormatV.layer.cornerRadius = 10
    dateShowV.layer.cornerRadius = 10
    dateHexFormatV.layer.cornerRadius = 10
    screenKeepActiveV.layer.cornerRadius = 10
    if let borderColor = UIColor(hex: "#3C3C431E")?.cgColor {
      timeHexFormatV.layer.borderWidth = 1
      timeHexFormatV.layer.borderColor = borderColor
      dateShowV.layer.borderWidth = 1
      dateShowV.layer.borderColor = borderColor
      dateHexFormatV.layer.borderWidth = 1
      dateHexFormatV.layer.borderColor = borderColor
      screenKeepActiveV.layer.borderWidth = 1
      screenKeepActiveV.layer.borderColor = borderColor
    }
  }

  // MARK: Navigation: Segue & UnwindSegue
  @IBAction func unwindToClock(_ sender: Any) {
    self.performSegue(withIdentifier: "unwindClock", sender: nil)
  }
}
