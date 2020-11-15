//
//  ViewController.swift
//  colorime
//
//  Created by raaowx on 20/10/2020.
//

import UIKit

// MARK: - Clock View Controller
class ClockViewController: UIViewController {
  @IBOutlet weak var colorimeV: UIView!
  @IBOutlet weak var dateL: UILabel!
  @IBOutlet weak var timeL: UILabel!
  @IBOutlet weak var settingsB: UIButton!
  override var prefersStatusBarHidden: Bool { return hideStatusBar }
  let presenter = ClockPresenter()
  var hideStatusBar = true {
    didSet {
      self.setNeedsStatusBarAppearanceUpdate()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.attachView(delegate: self)
    presenter.configureView()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    presenter.startClock()
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    presenter.stopClock()
  }

  @IBAction func screenTapped(_ sender: Any) {
    UIView.animate(withDuration: 0.5) {
      self.settingsB.isHidden.toggle()
      self.hideStatusBar = false
    } completion: { _ in
      Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
        UIView.animate(withDuration: 0.5) {
          self.settingsB.isHidden.toggle()
          self.hideStatusBar = true
        }
      }
    }
  }

  @IBAction func segueToSettings(_ sender: Any) {
    // TODO: Segue to settings
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

  func setSolidBackground(color: String) {
    guard let solidColor = UIColor(hex: color) else { return }
    colorimeV.backgroundColor = solidColor
  }

  func setGradientBackground(from start: String, to end: String) {
    guard let startColor = UIColor(hex: start) else { return }
    guard let endColor = UIColor(hex: end) else { return }
    let gradient = CAGradientLayer()
    gradient.frame = colorimeV.bounds
    gradient.colors = [startColor.cgColor, endColor.cgColor]
    // Remove last layer to keep the sublayer count at the minimum.
    // This will avoid memory collapse.
    colorimeV.layer.sublayers?.removeLast()
    colorimeV.layer.addSublayer(gradient)
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
