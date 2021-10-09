//
//  AboutPresenter.swift
//  colorime
//
//  Created by raaowx on 7/10/21.
//

import Foundation

protocol AboutDelegate: AnyObject {
  func loadHTML(from url: URL?, request: URLRequest?)
}

class AboutPresenter {
  private weak var delegate: AboutDelegate?

  init(delegate: AboutDelegate) {
    self.delegate = delegate
  }

  func requestHTML(for about: About) {
    guard let url = Bundle.main.url(
      forResource: about.filename,
      withExtension: about.filetype) else {
      self.delegate?.loadHTML(from: nil, request: nil)
      return
    }
    let request = URLRequest(url: url)
    self.delegate?.loadHTML(from: url, request: request)
  }
}
