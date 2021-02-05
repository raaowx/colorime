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

  func toVividDateHex() -> String? {
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

  func toVividTimeHex() -> String? {
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
}
