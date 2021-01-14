//
//  UIGradientView.swift
//  colorime
//
//  Created by raaowx on 14/1/21.
//

import UIKit

class UIGradientView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    initialize()
  }

  private func initialize() {
    autoresizingMask = [.flexibleWidth, .flexibleHeight]
    guard let layer = self.layer as? CAGradientLayer else { return }
    layer.frame = self.bounds
  }

  // This force layer class to be CAGradientLayer instead of CALayer
  override class var layerClass: AnyClass {
    return CAGradientLayer.self
  }

  func updateGradient(colors: CGColor...) {
    guard let layer = self.layer as? CAGradientLayer else { return }
    layer.colors = colors
  }

  func removeGradient() {
    guard let layer = self.layer as? CAGradientLayer else { return }
    layer.colors = nil
  }
}
