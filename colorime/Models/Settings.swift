//
//  Settings.swift
//  colorime
//
//  Created by raaowx on 11/11/2020.
//

import Foundation

struct Settings {
  static var shared = Settings()
  private let defaults: UserDefaults

  enum Options: String, CaseIterable {
    case hexTime = "colorime-time-hex"
    case showDate = "colorime-date-show"
    case hexDate = "colorime-date-hex"
    case keepActiveScreen = "colorime-screen-keepactive"
    case colorsScreen = "colorime-screen-colors"
  }

  enum Colors: Int {
    case normal = 0
    case bright = 1
    case vivid = 2
  }

  private init() {
    defaults = UserDefaults.standard
  }

  func read(option: Options) -> Any {
    switch option {
    case .hexTime, .showDate, .hexDate, .keepActiveScreen:
      return defaults.bool(forKey: option.rawValue)
    case .colorsScreen:
      return defaults.integer(forKey: option.rawValue)
    }
  }

  func write(option: Options, withValue value: Any) {
    defaults.setValue(value, forKey: option.rawValue)
  }
}
