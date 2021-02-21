//
//  SettingsPresenter.swift
//  colorime
//
//  Created by raaowx on 19/11/20.
//

protocol SettingsDelegate: class {
  func showContainer(option: Settings.Options)
  func loadSettings(option: Settings.Options, value: Any)
}

class SettingsPresenter {
  private weak var delegate: SettingsDelegate?
  private let settings = Settings.shared

  init(delegate: SettingsDelegate) {
    self.delegate = delegate
    for option in Settings.Options.allCases {
      delegate.loadSettings(option: option, value: settings.read(option: option))
      if option == .showDate, let bool = settings.read(option: option) as? Bool, bool {
        delegate.showContainer(option: .hexDate)
      }
    }
  }

  func updateSetting(option: Settings.Options, value: Any) {
    settings.write(option: option, withValue: value)
    if option == .showDate, let delegate = delegate {
      delegate.showContainer(option: .hexDate)
    }
  }
}
