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
  @IBOutlet weak var timeHexTipL: UILabel!
  @IBOutlet weak var dateShowV: UIView!
  @IBOutlet weak var dateShowS: UISwitch!
  @IBOutlet weak var dateHexFormatSV: UIStackView!
  @IBOutlet weak var dateHexFormatV: UIView!
  @IBOutlet weak var dateHexFormatS: UISwitch!
  @IBOutlet weak var dateHexTipL: UILabel!
  @IBOutlet weak var screenKeepActiveV: UIView!
  @IBOutlet weak var screenKeepActiveS: UISwitch!
  @IBOutlet weak var screenColorsV: UIView!
  @IBOutlet weak var screenColorsSC: UISegmentedControl!
  @IBOutlet weak var versionV: UIView!
  @IBOutlet weak var versionL: UILabel!
  @IBOutlet weak var sourceCodeV: UIView!
  @IBOutlet var sourceCodeTGR: UITapGestureRecognizer!
  @IBOutlet weak var licenseV: UIView!
  @IBOutlet var licenseTGR: UITapGestureRecognizer!
  @IBOutlet weak var attributionsV: UIView!
  @IBOutlet var attributionsTGR: UITapGestureRecognizer!
  var presenter: SettingsPresenter?

  override func viewDidLoad() {
    super.viewDidLoad()
    timeHexFormatV.layer.cornerRadius = 10
    dateShowV.layer.cornerRadius = 10
    dateHexFormatV.layer.cornerRadius = 10
    screenKeepActiveV.layer.cornerRadius = 10
    screenColorsV.layer.cornerRadius = 10
    versionV.layer.cornerRadius = 10
    sourceCodeV.layer.cornerRadius = 10
    licenseV.layer.cornerRadius = 10
    attributionsV.layer.cornerRadius = 10
    if let borderColor = UIColor(hex: "#3C3C431E")?.cgColor {
      timeHexFormatV.layer.borderWidth = 1
      timeHexFormatV.layer.borderColor = borderColor
      dateShowV.layer.borderWidth = 1
      dateShowV.layer.borderColor = borderColor
      dateHexFormatV.layer.borderWidth = 1
      dateHexFormatV.layer.borderColor = borderColor
      screenKeepActiveV.layer.borderWidth = 1
      screenKeepActiveV.layer.borderColor = borderColor
      screenColorsV.layer.borderWidth = 1
      screenColorsV.layer.borderColor = borderColor
      versionV.layer.borderWidth = 1
      versionV.layer.borderColor = borderColor
      sourceCodeV.layer.borderWidth = 1
      sourceCodeV.layer.borderColor = borderColor
      licenseV.layer.borderWidth = 1
      licenseV.layer.borderColor = borderColor
      attributionsV.layer.borderWidth = 1
      attributionsV.layer.borderColor = borderColor
    }
    if UIDevice.current.localizedModel == Settings.Devices.ipad.rawValue {
      timeHexTipL.font = UIFont(name: Settings.Fonts.orbitronlight.rawValue, size: 14.0)
      dateHexTipL.font = UIFont(name: Settings.Fonts.orbitronlight.rawValue, size: 14.0)
    }
    timeHexS.addTarget(self, action: #selector(switchValueChanged(which:)), for: .valueChanged)
    dateShowS.addTarget(self, action: #selector(switchValueChanged(which:)), for: .valueChanged)
    dateHexFormatS.addTarget(self, action: #selector(switchValueChanged(which:)), for: .valueChanged)
    screenKeepActiveS.addTarget(self, action: #selector(switchValueChanged(which:)), for: .valueChanged)
    screenColorsSC.addTarget(self, action: #selector(segmentedControlValueChanged(which:)), for: .valueChanged)
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
      presenter?.updateSetting(option: .keepActiveScreen, value: which.isOn)
    default: return
    }
  }

  @objc func segmentedControlValueChanged(which: UISegmentedControl) {
    switch which {
    case screenColorsSC:
      presenter?.updateSetting(option: .colorsScreen, value: which.selectedSegmentIndex)
    default: return
    }
  }

  @IBAction func buttonTapped(_ sender: UITapGestureRecognizer) {
    switch sender {
    case sourceCodeTGR:
      guard let url = About.sourcecode.url else { return }
      if UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:])
      }
    case licenseTGR:
      self.performSegue(withIdentifier: "segueLicense", sender: nil)
    case attributionsTGR:
      self.performSegue(withIdentifier: "segueAttributions", sender: nil)
    default: break
    }
  }

  // MARK: Navigation: Segue & UnwindSegue
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if About.allCases.contains(where: { $0.segueID == segue.identifier }) {
      guard let aboutVC = segue.destination as? AboutViewController else { return }
      switch segue.identifier {
      case About.license.segueID:
        aboutVC.aboutWhat = .license
      case About.attributions.segueID:
        aboutVC.aboutWhat = .attributions
      default: break
      }
    }
  }

  @IBAction func segueBackToClock(_ sender: Any) {
    self.performSegue(withIdentifier: "unwindClock", sender: nil)
  }

  @IBAction func unwindToSettings(_ unwindSegue: UIStoryboardSegue) { }
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

  func loadSettings(option: Settings.Options, value: Any) {
    switch option {
    case .hexTime:
      if let value = value as? Bool {
        timeHexS.setOn(value, animated: true)
      }
    case .showDate:
      if let value = value as? Bool {
        dateShowS.setOn(value, animated: true)
      }
    case .hexDate:
      if let value = value as? Bool {
        dateHexFormatS.setOn(value, animated: true)
      }
    case .keepActiveScreen:
      if let value = value as? Bool {
        screenKeepActiveS.setOn(value, animated: true)
      }
    case .colorsScreen:
      if let value = value as? Int {
        screenColorsSC.selectedSegmentIndex = value
      }
    }
  }

  func loadVersion(_ version: String) {
    self.versionL.text = version
  }
}
