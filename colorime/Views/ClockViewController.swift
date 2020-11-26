//
//  ClockViewController.swift
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
  override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
  override var prefersStatusBarHidden: Bool { return hideStatusBar }
  var presenter: ClockPresenter?
  var statusBarTimer: Timer?
  var hideStatusBar = true {
    didSet {
      self.setNeedsStatusBarAppearanceUpdate()
    }
  }
  var showingStatusBar = false

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter = ClockPresenter(delegate: self)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    presenter?.startClock()
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    presenter?.stopClock()
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
