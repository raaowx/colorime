//
//  UIColor.swift
//  colorime
//
//  Created by raaowx on 09/11/2020.
//

import UIKit

extension UIColor {
  convenience init?(hex: String) {
    if !hex.hasPrefix("#") || ![4, 5, 7, 9].contains(hex.count) {
      return nil
    }

    let start = hex.index(hex.startIndex, offsetBy: 1)
    var color = String(hex[start...])

    if [3, 4].contains(color.count) {
      for i in 0..<color.count * 2 {
        if i % 2 == 0 {
          continue
        }
        let index = color.index(color.startIndex, offsetBy: i - 1)
        let nextIndex = color.index(after: index)
        let char = color[index]
        color.insert(char, at: nextIndex)
      }
    }

    if color.count == 6 {
      color.append("FF")
    }

    var number: UInt64 = 0
    let scanner = Scanner(string: color)
    if !scanner.scanHexInt64(&number) {
      return nil
    }

    let red, green, blue, alpha: CGFloat
    red = CGFloat((number & 0xff000000) >> 24) / 255
    green = CGFloat((number & 0x00ff0000) >> 16) / 255
    blue = CGFloat((number & 0x0000ff00) >> 8) / 255
    alpha = CGFloat(number & 0x000000ff) / 255
    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
