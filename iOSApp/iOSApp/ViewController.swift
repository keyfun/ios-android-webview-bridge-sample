//
//  ViewController.swift
//  iOSApp
//
//  Created by Key Hui on 11/2/19.
//  Copyright © 2019 keyfun. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {

    var webView: WKWebView!
    let host = "localhost"
    let kHandlerName = "demo"
    let urlPath = "http://localhost:9000"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initWebView()
        loadUrl(urlPath)
    }
    
    func initWebView() {
        let webViewFrame = getWebViewFrame()
        webView = WKWebView(frame: webViewFrame, configuration: getConfiguration())
        view.addSubview(webView)

        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let host = navigationAction.request.url?.host {
            if host == self.host {
                decisionHandler(.allow)
                return
            }
        }
        print("cancel: \(String(describing: navigationAction.request.url?.host))")
        decisionHandler(.cancel)
    }

    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let ac = UIAlertController(title: "iOS Alert", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
        completionHandler()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish")
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            print(Float(webView.estimatedProgress))
        }

        if keyPath == "title" {
            if let title = webView.title {
                print(title)
            }
        }
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let body = message.body as? [String: Any] else { return }
        guard let data = body["data"] as? [String: Any] else { return }
        print(data)
        
        let ac = UIAlertController(title: "Message Received:", message: data.description, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
    }

    func getWebViewFrame() -> CGRect {
        return CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height)
    }

    func loadUrl(_ urlPath: String) {
        if let url = URL(string: urlPath) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    private func getConfiguration() -> WKWebViewConfiguration {
        let configuration = WKWebViewConfiguration()

        let userContentController = WKUserContentController()
        userContentController.add(self, name: kHandlerName)

        configuration.dataDetectorTypes = [.all]
        configuration.userContentController = userContentController

        return configuration
    }

}

