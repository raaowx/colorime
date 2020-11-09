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
    formatter.dateFormat = "DD/MM/YY"
    return formatter.string(from: self)
  }

  func toTimeString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss"
    return formatter.string(from: self)
  }

  func toDateHex() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "DDMMYY"
    return "#\(formatter.string(from: self))"
  }

  func toTimeHex() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HHmmss"
    return "#\(formatter.string(from: self))"
  }
}
