//
//  ClockPresenter.swift
//  colorime
//
//  Created by raaowx on 14/11/20.
//
import Foundation

protocol ClockDelegate: AnyObject {
  func toggleShowDate(_ show: Bool)
  func toggleScreenActive(_ keepActive: Bool)
  func setColorsAppereance(_ color: Settings.Colors)
  func setSolidBackground(color: String)
  func setGradientBackground(from start: String, to end: String)
  func setTime(time: String)
  func setDate(date: String)
}

class ClockPresenter {
  private weak var delegate: ClockDelegate?
  private var timer: Timer?

  init(delegate: ClockDelegate) {
    self.delegate = delegate
    configureView()
  }

  func configureView() {
    guard let delegate = delegate else { return }
    let settings = Settings.shared
    if let bool = settings.read(option: .showDate) as? Bool {
      delegate.toggleShowDate(bool)
    }
    if let bool = settings.read(option: .keepActiveScreen) as? Bool {
      delegate.toggleScreenActive(bool)
    }
    if let integer = settings.read(option: .colorsScreen) as? Int,
      let color = Settings.Colors(rawValue: integer) {
      delegate.setColorsAppereance(color)
    }
  }

  func startClock() {
    if let timer = timer, timer.isValid { return }
    let settings = Settings.shared
    var closures: [ClockClosure] = []
    closures.append(configureTime(withSettings: settings))
    if let closure = configureDate(withSettings: settings) {
      closures.append(closure)
    }
    closures.append(configuraBackground(withSettings: settings))
    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
      guard let delegate = self.delegate else { return }
      let date = Date()
      for closure in closures {
        closure(delegate, date)
      }
    }
    timer?.fire()
  }

  func stopClock() {
    timer?.invalidate()
  }

  private func configureTime(withSettings settings: Settings) -> ClockClosure {
    if let bool = settings.read(option: .hexTime) as? Bool, bool {
      return ClockPresenter.hexTimeClosure
    } else {
      return ClockPresenter.timeClosure
    }
  }

  private func configureDate(withSettings settings: Settings) -> ClockClosure? {
    if let bool = settings.read(option: .showDate) as? Bool, bool {
      if let bool = settings.read(option: .hexDate) as? Bool, bool {
        return ClockPresenter.hexDateClosure
      } else {
        return ClockPresenter.dateClosure
      }
    }
    return nil
  }

  private func configuraBackground(withSettings settings: Settings) -> ClockClosure {
    if let bool = settings.read(option: .showDate) as? Bool, bool {
      guard let integer = settings.read(option: .colorsScreen) as? Int,
        let color = Settings.Colors(rawValue: integer) else {
        return ClockPresenter.gradientNormalClosure
      }
      switch color {
      case .normal:
        return ClockPresenter.gradientNormalClosure
      case .bright:
        return ClockPresenter.gradientBrightClosure
      case .vivid:
        return ClockPresenter.gradientVividClosure
      }
    } else {
      guard let integer = settings.read(option: .colorsScreen) as? Int,
        let color = Settings.Colors(rawValue: integer) else {
        return ClockPresenter.solidNormalClosure
      }
      switch color {
      case .normal:
        return ClockPresenter.solidNormalClosure
      case .bright:
        return ClockPresenter.solidBrightClosure
      case .vivid:
        return ClockPresenter.solidVividClosure
      }
    }
  }
}

// MARK: - Clock Closures
extension ClockPresenter {
  typealias ClockClosure = (_ delegate: ClockDelegate, _ date: Date) -> Void

  private static let timeClosure: ClockClosure = { delegate, date in
    delegate.setTime(time: date.toTimeString())
  }

  private static let hexTimeClosure: ClockClosure = { delegate, date in
    delegate.setTime(time: date.toTimeHex())
  }

  private static let dateClosure: ClockClosure = { delegate, date in
    delegate.setDate(
      date: (Bundle.main.preferredLocalizations.first == Settings.Localization.american.rawValue)
      ? date.toAmericanDateString()
      : date.toDateString())
  }

  private static let hexDateClosure: ClockClosure = { delegate, date in
    delegate.setDate(
      date: (Bundle.main.preferredLocalizations.first == Settings.Localization.american.rawValue)
      ? date.toAmericanDateHex()
      : date.toDateHex())
  }

  private static let solidNormalClosure: ClockClosure = { delegate, date in
    delegate.setSolidBackground(color: date.toTimeHex())
  }

  private static let solidBrightClosure: ClockClosure = { delegate, date in
    guard let color = date.toBrightTimeHex() else {
      delegate.setSolidBackground(color: date.toTimeHex())
      return
    }
    delegate.setSolidBackground(color: color)
  }

  private static let solidVividClosure: ClockClosure = { delegate, date in
    guard let color = date.toVividTimeHex() else {
      delegate.setSolidBackground(color: date.toTimeHex())
      return
    }
    delegate.setSolidBackground(color: color)
  }

  private static let gradientNormalClosure: ClockClosure = { delegate, date in
    delegate.setGradientBackground(
      from: (Bundle.main.preferredLocalizations.first == Settings.Localization.american.rawValue)
      ? date.toAmericanDateHex()
      : date.toDateHex(),
      to: date.toTimeHex())
  }

  private static let gradientBrightClosure: ClockClosure = { delegate, date in
    guard let start = (Bundle.main.preferredLocalizations.first == Settings.Localization.american.rawValue)
      ? date.toAmericanBrightDateHex()
      : date.toBrightDateHex(),
      let end = date.toBrightTimeHex() else {
      gradientNormalClosure(delegate, date)
      return
    }
    delegate.setGradientBackground(from: start, to: end)
  }

  private static let gradientVividClosure: ClockClosure = { delegate, date in
    guard let start = (Bundle.main.preferredLocalizations.first == Settings.Localization.american.rawValue)
      ? date.toAmericanVividDateHex()
      : date.toVividDateHex(),
      let end = date.toVividTimeHex() else {
      gradientNormalClosure(delegate, date)
      return
    }
    delegate.setGradientBackground(from: start, to: end)
  }
}
