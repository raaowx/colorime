//
//  About.swift
//  colorime
//
//  Created by raaowx on 7/10/21.
//

import Foundation

enum About: String, CaseIterable {
  case sourcecode = "about-source-code"
  case license = "about-license"
  case attributions = "about-attributions"
  var segueID: String {
    switch self {
    case .license: return "segueLicense"
    case .attributions: return "segueAttributions"
    default: return ""
    }
  }
  var filename: String {
    switch self {
    case .license: return "license"
    case .attributions: return "attributions"
    default: return ""
    }
  }
  var filetype: String {
    switch self {
    case .license: return "html"
    case .attributions: return "html"
    default: return ""
    }
  }
  var url: URL? {
    switch self {
    case .sourcecode:
      return URL(string: "https://github.com/raaowx/colorime")
    default: return nil
    }
  }
}
