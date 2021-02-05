//
//  SettingsViewController.swift
//  colorime
//
//  Created by raaowx on 19/11/20.
//

import UIKit

// MARK: - Settings View Controller
class SettingsViewController: UIViewController {
  @IBOutlet weak var timeHexFormatV: UIView!
  @IBOutlet weak var timeHexS: UISwitch!
  @IBOutlet weak var dateShowV: UIView!
  @IBOutlet weak var dateShowS: UISwitch!
  @IBOutlet weak var dateHexFormatSV: UIStackView!
  @IBOutlet weak var dateHexFormatV: UIView!
  @IBOutlet weak var dateHexFormatS: UISwitch!
  @IBOutlet weak var screenKeepActiveV: UIView!
  @IBOutlet weak var screenKeepActiveS: UISwitch!
  @IBOutlet weak var screenVividColorsV: UIView!
  @IBOutlet weak var screenVividColorsS: UISwitch!
  var presenter: SettingsPresenter?

  override func viewDidLoad() {
    super.viewDidLoad()
    timeHexFormatV.layer.cornerRadius = 10
    dateShowV.layer.cornerRadius = 10
    dateHexFormatV.layer.cornerRadius = 10
    screenKeepActiveV.layer.cornerRadius = 10
    screenVividColorsV.layer.cornerRadius = 10
    if let borderColor = UIColor(hex: "#3C3C431E")?.cgColor {
      timeHexFormatV.layer.borderWidth = 1
      timeHexFormatV.layer.borderColor = borderColor
      dateShowV.layer.borderWidth = 1
      dateShowV.layer.borderColor = borderColor
      dateHexFormatV.layer.borderWidth = 1
      dateHexFormatV.layer.borderColor = borderColor
      screenKeepActiveV.layer.borderWidth = 1
      screenKeepActiveV.layer.borderColor = borderColor
      screenVividColorsV.layer.borderWidth = 1
      screenVividColorsV.layer.borderColor = borderColor
    }
    timeHexS.addTarget(self, action: #selector(switchValueChanged(which:)), for: .valueChanged)
    dateShowS.addTarget(self, action: #selector(switchValueChanged(which:)), for: .valueChanged)
    dateHexFormatS.addTarget(self, action: #selector(switchValueChanged(which:)), for: .valueChanged)
    screenKeepActiveS.addTarget(self, action: #selector(switchValueChanged(which:)), for: .valueChanged)
    screenVividColorsS.addTarget(self, action: #selector(switchValueChanged(which:)), for: .valueChanged)
    presenter = SettingsPresenter(delegate: self)
  }

  @objc func switchValueChanged(which: UISwitch) {
    switch which {
    case timeHexS:
      presenter?.updateSetting(option: .hexTime, value: which.isOn)
    case dateShowS:
      presenter?.updateSetting(option: .showDate, value: which.isOn)
    case dateHexFormatS:
      presenter?.updateSetting(option: .hexDate, value: which.isOn)
    case screenKeepActiveS:
      presenter?.updateSetting(option: .keepScreenActive, value: which.isOn)
    case screenVividColorsS:
      presenter?.updateSetting(option: .vividColors, value: which.isOn)
    default: return
    }
  }

  // MARK: Navigation: Segue & UnwindSegue
  @IBAction func segueBackToClock(_ sender: Any) {
    self.performSegue(withIdentifier: "unwindClock", sender: nil)
  }
}

// MARK: - Settings Delegate
extension SettingsViewController: SettingsDelegate {
  func showContainer(option: Settings.Options) {
    UIView.animate(withDuration: 0.5) { [self] in
      switch option {
      case .hexDate:
        if dateHexFormatSV.isHidden {
          dateHexFormatSV.alpha = 1
        } else {
          dateHexFormatSV.alpha = 0
        }
        dateHexFormatSV.isHidden.toggle()
      default: return
      }
    }
  }

  func loadSettings(option: Settings.Options, value: Bool) {
    switch option {
    case .hexTime:
      timeHexS.setOn(value, animated: true)
    case .showDate:
      dateShowS.setOn(value, animated: true)
    case .hexDate:
      dateHexFormatS.setOn(value, animated: true)
    case .keepScreenActive:
      screenKeepActiveS.setOn(value, animated: true)
    case .vividColors:
      screenVividColorsS.setOn(value, animated: true)
    }
  }
}
