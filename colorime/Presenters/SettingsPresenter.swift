//
//  SettingsPresenter.swift
//  colorime
//
//  Created by raaowx on 19/11/20.
//

import Foundation

class SettingsPresenter {
  private weak var delegate: SettingsDelegate?
  private let settings = Settings.shared

  init(delegate: SettingsDelegate) {
    self.delegate = delegate
    for option in Settings.Options.allCases {
      delegate.loadSettings(option: option, value: settings.read(option: option))
      if option == .showDate, settings.read(option: option) {
        delegate.showContainer(option: .hexDate)
      }
    }
  }

  func updateSetting(option: Settings.Options, value: Bool) {
    settings.write(option: option, withValue: value)
    if option == .showDate, let delegate = delegate {
      delegate.showContainer(option: .hexDate)
    }
  }
}

protocol SettingsDelegate: class {
  func showContainer(option: Settings.Options)
  func loadSettings(option: Settings.Options, value: Bool)
}
