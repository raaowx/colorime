//
//  ClockPresenter.swift
//  colorime
//
//  Created by raaowx on 14/11/20.
//
import Foundation

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
    delegate.toggleShowDate(settings.read(option: .showDate))
    delegate.toggleScreenActive(settings.read(option: .keepScreenActive))
    delegate.toggleVividColors(settings.read(option: .vividColors))
  }

  func startClock() {
    if let timer = timer, timer.isValid {
      return
    }
    var closures: [(_ delegate: ClockDelegate, _ date: Date) -> Void] = []
    let settings = Settings.shared

    if settings.read(option: .hexTime) {
      closures.append { delegate, date in
        delegate.setTime(time: date.toTimeHex())
      }
    } else {
      closures.append { delegate, date in
        delegate.setTime(time: date.toTimeString())
      }
    }

    if settings.read(option: .showDate) {
      if settings.read(option: .hexDate) {
        closures.append { delegate, date in
          delegate.setDate(date: date.toDateHex())
        }
      } else {
        closures.append { delegate, date in
          delegate.setDate(date: date.toDateString())
        }
      }
      if settings.read(option: .vividColors) {
        closures.append { delegate, date in
          guard let start = date.toVividDateHex(),
            let end = date.toVividTimeHex() else {
            delegate.setGradientBackground(from: date.toDateHex(), to: date.toTimeHex())
            return
          }
          delegate.setGradientBackground(from: start, to: end)
        }
      } else {
        closures.append { delegate, date in
          delegate.setGradientBackground(from: date.toDateHex(), to: date.toTimeHex())
        }
      }
    } else {
      if settings.read(option: .vividColors) {
        closures.append { delegate, date in
          guard let color = date.toVividTimeHex() else {
            delegate.setSolidBackground(color: date.toTimeHex())
            return
          }
          delegate.setSolidBackground(color: color)
        }
      } else {
        closures.append { delegate, date in
          delegate.setSolidBackground(color: date.toTimeHex())
        }
      }
    }

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
}

protocol ClockDelegate: class {
  func toggleShowDate(_ show: Bool)
  func toggleScreenActive(_ keepActive: Bool)
  func toggleVividColors(_ vivid: Bool)
  func setSolidBackground(color: String)
  func setGradientBackground(from start: String, to end: String)
  func setTime(time: String)
  func setDate(date: String)
}
