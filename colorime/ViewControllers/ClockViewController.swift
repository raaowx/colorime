//
//  ClockViewController.swift
//  colorime
//
//  Created by raaowx on 20/10/2020.
//

import UIKit

// MARK: - Clock View Controller
class ClockViewController: UIViewController {
  @IBOutlet weak var colorimeV: UIGradientView!
  @IBOutlet weak var dateL: UILabel!
  @IBOutlet weak var timeL: UILabel!
  @IBOutlet weak var settingsB: UIButton!
  override var preferredStatusBarStyle: UIStatusBarStyle { return statusBarStyle }
  override var prefersStatusBarHidden: Bool { return hideStatusBar }
  var presenter: ClockPresenter?
  var statusBarTimer: Timer?
  var statusBarStyle: UIStatusBarStyle = .lightContent {
    didSet {
      self.setNeedsStatusBarAppearanceUpdate()
    }
  }
  var hideStatusBar = true {
    didSet {
      self.setNeedsStatusBarAppearanceUpdate()
    }
  }
  var showingStatusBar = false

  override func viewDidLoad() {
    super.viewDidLoad()
    if UIDevice.current.localizedModel == Settings.Devices.ipad.rawValue {
      dateL.font = UIFont(name: Settings.Fonts.orbitronlight.rawValue, size: 80.0)
      timeL.font = UIFont(name: Settings.Fonts.orbitronlight.rawValue, size: 80.0)
    }
    presenter = ClockPresenter(delegate: self)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(orientationDidChange),
      name: UIDevice.orientationDidChangeNotification,
      object: nil)
    presenter?.startClock()
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    presenter?.stopClock()
    NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    adjustClockSize()
  }

  @objc func orientationDidChange() {
    adjustClockSize()
  }

  @IBAction func screenTapped(_ sender: Any) {
    if !showingStatusBar {
      showingStatusBar.toggle()
      UIView.animate(withDuration: 0.3) {
        self.settingsB.isHidden.toggle()
        self.hideStatusBar.toggle()
      } completion: { _ in
        self.statusBarTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
          UIView.animate(withDuration: 0.3) {
            self.settingsB.isHidden.toggle()
            self.hideStatusBar.toggle()
            self.showingStatusBar.toggle()
          }
        }
      }
    }
  }

  // MARK: Navigation: Segue & UnwindSegue
  @IBAction func segueToSettings(_ sender: Any) {
    if let timer = statusBarTimer, timer.isValid {
      timer.fire()
    }
    self.performSegue(withIdentifier: "segueSettings", sender: nil)
  }

  @IBAction func unwindToClock(_ unwindSegue: UIStoryboardSegue) {
    presenter?.configureView()
    presenter?.startClock()
  }
}

// MARK: - Private Functions
extension ClockViewController {
  private func adjustClockSize() {
    if UIDevice.current.localizedModel == Settings.Devices.ipad.rawValue {
      switch traitCollection.horizontalSizeClass {
      case .regular:
        dateL.font = UIFont(name: Settings.Fonts.orbitronlight.rawValue, size: 80.0)
        timeL.font = UIFont(name: Settings.Fonts.orbitronlight.rawValue, size: 80.0)
      default:
        if UIDevice.current.orientation.isPortrait {
          dateL.font = UIFont(name: Settings.Fonts.orbitronlight.rawValue, size: 40.0)
          timeL.font = UIFont(name: Settings.Fonts.orbitronlight.rawValue, size: 40.0)
          return
        }
        dateL.font = UIFont(name: Settings.Fonts.orbitronlight.rawValue, size: 50.0)
        timeL.font = UIFont(name: Settings.Fonts.orbitronlight.rawValue, size: 50.0)
      }
    }
  }
}

// MARK: - Clock Delegate
extension ClockViewController: ClockDelegate {
  func toggleShowDate(_ show: Bool) {
    dateL.text = nil
    dateL.isHidden = !show
    colorimeV.backgroundColor = .clear
    colorimeV.layer.sublayers?.removeAll()
  }

  func toggleScreenActive(_ keepActive: Bool) {
    UIApplication.shared.isIdleTimerDisabled = keepActive
  }

  func setColorsAppereance(_ color: Settings.Colors) {
    switch color {
    case .normal:
      statusBarStyle = .lightContent
      settingsB.tintColor = UIColor(named: "clock-normal")
      dateL.textColor = UIColor(named: "clock-normal")
      timeL.textColor = UIColor(named: "clock-normal")
    case .bright, .vivid:
      statusBarStyle = .darkContent
      settingsB.tintColor = UIColor(named: "clock-vivid")
      dateL.textColor = UIColor(named: "clock-vivid")
      timeL.textColor = UIColor(named: "clock-vivid")
    }
  }

  func setSolidBackground(color: String) {
    colorimeV.removeGradient()
    guard let solidColor = UIColor(hex: color) else { return }
    colorimeV.backgroundColor = solidColor
  }

  func setGradientBackground(from start: String, to end: String) {
    guard let startColor = UIColor(hex: start) else { return }
    guard let endColor = UIColor(hex: end) else { return }
    colorimeV.updateGradient(colors: startColor.cgColor, endColor.cgColor)
  }

  func setTime(time: String) {
    if timeL.isHidden {
      timeL.isHidden.toggle()
    }
    timeL.text = time
  }

  func setDate(date: String) {
    if dateL.isHidden {
      dateL.isHidden.toggle()
    }
    dateL.text = date
  }
}
