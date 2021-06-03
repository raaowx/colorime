//
//  Date.swift
//  colorime
//
//  Created by raaowx on 09/11/2020.
//

import Foundation

extension Date {
  func toDateString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yy"
    return formatter.string(from: self)
  }

  func toTimeString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss"
    return formatter.string(from: self)
  }

  func toDateHex() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "ddMMyy"
    return "#\(formatter.string(from: self))"
  }

  func toTimeHex() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HHmmss"
    return "#\(formatter.string(from: self))"
  }

  func toBrightDateHex() -> String? {
    let hex = Array<String>.hex
    let formatter = DateFormatter()
    formatter.dateFormat = "ddMMyy"
    var date = "#"
    for char in formatter.string(from: self) {
      guard let index = hex.firstIndex(of: "\(char)") else { return nil }
      date.append(hex[abs(index - hex.count + 1)])
    }
    return date
  }

  func toBrightTimeHex() -> String? {
    let hex = Array<String>.hex
    let formatter = DateFormatter()
    formatter.dateFormat = "HHmmss"
    var date = "#"
    for char in formatter.string(from: self) {
      guard let index = hex.firstIndex(of: "\(char)") else { return nil }
      date.append(hex[abs(index - hex.count + 1)])
    }
    return date
  }

  func toVividDateHex() -> String? {
    let hex = Array<String>.hex
    let formatter = DateFormatter()
    formatter.dateFormat = "ddMMyy"
    var date = "#"
    for char in formatter.string(from: self) {
      guard let index = hex.firstIndex(of: "\(char)") else { return nil }
      let oppositeIndex = abs(index - hex.count + 1)
      date.append(hex[abs(oppositeIndex - index)])
    }
    return date
  }

  func toVividTimeHex() -> String? {
    let hex = Array<String>.hex
    let formatter = DateFormatter()
    formatter.dateFormat = "HHmmss"
    var date = "#"
    for char in formatter.string(from: self) {
      guard let index = hex.firstIndex(of: "\(char)") else { return nil }
      let oppositeIndex = abs(index - hex.count + 1)
      date.append(hex[abs(oppositeIndex - index)])
    }
    return date
  }
}

// MARK: - American Localization
extension Date {
  func toAmericanDateString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yy"
    return formatter.string(from: self)
  }

  func toAmericanDateHex() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMddyy"
    return "#\(formatter.string(from: self))"
  }

  func toAmericanBrightDateHex() -> String? {
    let hex = Array<String>.hex
    let formatter = DateFormatter()
    formatter.dateFormat = "MMddyy"
    var date = "#"
    for char in formatter.string(from: self) {
      guard let index = hex.firstIndex(of: "\(char)") else { return nil }
      date.append(hex[abs(index - hex.count + 1)])
    }
    return date
  }

  func toAmericanVividDateHex() -> String? {
    let hex = Array<String>.hex
    let formatter = DateFormatter()
    formatter.dateFormat = "MMddyy"
    var date = "#"
    for char in formatter.string(from: self) {
      guard let index = hex.firstIndex(of: "\(char)") else { return nil }
      let oppositeIndex = abs(index - hex.count + 1)
      date.append(hex[abs(oppositeIndex - index)])
    }
    return date
  }
}
