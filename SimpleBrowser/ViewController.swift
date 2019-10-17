//
//  ViewController.swift
//  SimpleBrowser
//
//  Created by Roxanne Zhang on 9/17/19.
//  Copyright © 2019 Roxanne Zhang. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, UITextFieldDelegate {
  
  @IBOutlet weak var webView: WKWebView!
  @IBOutlet weak var locationField: UITextField!
  @IBOutlet weak var back: UIBarButtonItem!
  @IBOutlet weak var forward: UIBarButtonItem!
  @IBOutlet weak var action: UIBarButtonItem!
  @IBOutlet weak var refresh: UIBarButtonItem!
  @IBOutlet weak var stop: UIBarButtonItem!
  @IBOutlet weak var go: UIBarButtonItem!


  override func viewDidLoad() {
    super.viewDidLoad()
    webView.navigationDelegate = self    
  }
  
  override func viewDidAppear(_ animated: Bool)
  {
    let urlString:String = "https://www.apple.com" // default page
    let url:URL = URL(string: urlString)!
    let urlRequest:URLRequest = URLRequest(url: url)
    webView.load(urlRequest)
    locationField.text = urlString
  }
  
  @IBAction func goTapped(_ sender: Any) {
    let url = URL(string: "https://" + locationField!.text!)!
    webView.load(URLRequest(url: url))
  }
  
  @IBAction func refreshTapped(_ sender: Any) {
    webView.reload()
  }
  
  @IBAction func backTapped(_ sender: Any) {
    if webView.canGoBack {
      webView.goBack()
    }
  }
  
  @IBAction func forwardTapped(_ sender: Any) {
    if webView.canGoForward {
      webView.goForward()
    }
  }
  
  @IBAction func stopTapped(_ sender: Any) {
    webView.stopLoading()
  }
  
  @IBAction func shareButtonTapped(_ sender: Any) {
    let urlString:String = locationField.text!
    let url:URL = URL(string: urlString)!
    
    let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
    navigationController?.present(activityViewController, animated: true)
  }
  
  func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
    locationField.text = ""
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let url = URL(string: "https://" + locationField!.text!)!
    webView.load(URLRequest(url: url))
    
    locationField.resignFirstResponder()
    return true
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    back.isEnabled = webView.canGoBack
    forward.isEnabled = webView.canGoForward
    // [Add Code for Forward Button, its similar!]
    
    locationField.text = webView.url?.absoluteString
  }
}

