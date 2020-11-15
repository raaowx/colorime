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

  enum Options: String {
    case showDate = "colorime-date-show"
    case hexTime = "colorime-time-hex"
    case hexDate = "colorime-date-hex"
    case keepScreenActive = "colorime-screen-keepactive"
  }

  private init() {
    defaults = UserDefaults.standard
  }

  func read(option: Options) -> Bool {
    defaults.bool(forKey: option.rawValue)
  }

  func write(option: Options, withValue value: Bool) {
    defaults.setValue(value, forKey: option.rawValue)
  }
}
