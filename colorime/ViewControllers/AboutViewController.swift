//
//  AboutViewController.swift
//  colorime
//
//  Created by raaowx on 7/10/21.
//

import UIKit
import WebKit

// MARK: - About View Controller
class AboutViewController: UIViewController {
  @IBOutlet weak var aboutWKWV: WKWebView!
  @IBOutlet weak var aboutNI: UINavigationItem!
  var presenter: AboutPresenter?
  var aboutWhat: About?

  override func viewDidLoad() {
    super.viewDidLoad()
    guard let aboutWhat = aboutWhat else { return }
    aboutNI.title = NSLocalizedString(aboutWhat.rawValue, comment: "")
    presenter = AboutPresenter(delegate: self)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    guard let aboutWhat = aboutWhat else {
      segueBackToSettings(self)
      return
    }
    presenter?.requestHTML(for: aboutWhat)
  }

  // MARK: Navigation: Segue & UnwindSegue
  @IBAction func segueBackToSettings(_ sender: Any) {
    self.performSegue(withIdentifier: "unwindSettings", sender: nil)
  }
}

// MARK: - About Delegate
extension AboutViewController: AboutDelegate {
  func loadHTML(from url: URL?, request: URLRequest?) {
    guard let url = url, let request = request else {
      segueBackToSettings(self)
      return
    }
    aboutWKWV.navigationDelegate = self
    aboutWKWV.loadFileURL(url, allowingReadAccessTo: url)
    aboutWKWV.load(request)
  }
}

// MARK: - WKWebView Delegate
extension AboutViewController: WKNavigationDelegate {
  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    if navigationAction.navigationType == .linkActivated,
      let url = navigationAction.request.url,
      UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url, options: [:])
      decisionHandler(.cancel)
      return
    }
    decisionHandler(.allow)
  }
}
