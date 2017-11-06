//
//  ViewController.swift
//  Jira
//
//  Created by John W. Long on 11/5/17.
//  Copyright (c) 2017 John W. Long. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController, WebPolicyDelegate, WebFrameLoadDelegate, WebUIDelegate {
    
    // Attributes
    
    var addressBar: NSTextField!
    var urlTimer: Timer!
    
    @IBOutlet weak var webView: WebView!
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    
    
    // Initialization
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        urlTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.urlTimerTick), userInfo: nil, repeats: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.policyDelegate = self
        webView.frameLoadDelegate = self
        webView.uiDelegate = self
    }
    
    override func viewDidAppear() {
        let wc = self.view.window?.windowController as! WindowController
        addressBar = wc.addressBar
        goHome(self)
    }
    
    
    // Actions
    
    @IBAction func doRefresh(_: AnyObject) {
        webView.reload(self)
    }
    
    @IBAction func goHome(_: AnyObject) {
        loadUrl("https://cloudbees.atlassian.net")
    }
    
    @IBAction func goBack(_: AnyObject) {
        webView.goBack()
    }
    
    @IBAction func goForward(_: AnyObject) {
        webView.goForward()
    }
    
    @IBAction func goBackForward(_ sender: NSSegmentedControl) {
        let tag = sender.selectedSegment
        if (tag == 0) {
            webView.goBack()
        } else {
            webView.goForward()
        }
    }
    
    
    // Supporting functions
    
    func loadUrl(_ url: String) {
        webView.mainFrameURL = url
    }
    
    func loadExternalUrl(_ url: String) {
        NSWorkspace.shared().open(URL(string: url)!)
    }
    
    func urlTimerTick() {
        if (addressBar != nil) {
            addressBar.stringValue = webView.mainFrameURL
        }
    }
    
    
    // WebView events

    func webView(_ sender: WebView!, didStartProvisionalLoadFor frame: WebFrame!) {
        progressIndicator.startAnimation(self)
    }
    
    func webView(_ sender: WebView!, didFinishLoadFor frame: WebFrame!) {
        progressIndicator.stopAnimation(self)
    }
    
//  override func webView(_ sender: WebView!, decidePolicyForNavigationAction actionInformation: [AnyHashable: Any]!, request: URLRequest!, frame: WebFrame!, decisionListener listener: WebPolicyDecisionListener!) {
//        if (sender.isEqual(webView)) {
//            listener.use()
//        } else {
//            let index = actionInformation.index(forKey: WebActionOriginalURLKey)!
//            let pair = actionInformation[index]
//            let url = pair.1.debugDescription! // TODO: Figure out how to convert this into a string properly
//            loadExternalUrl(url)
//            listener.ignore()
//        }
//    }
//    
//    override func webView(_ webView: WebView!, decidePolicyForNewWindowAction actionInformation: [AnyHashable: Any]!, request: URLRequest!, newFrameName frameName: String!, decisionListener listener: WebPolicyDecisionListener!) {
//        let index = actionInformation.index(forKey: WebActionOriginalURLKey)!
//        let pair = actionInformation[index]
//        let url = pair.1.debugDescription! // TODO: Figure out how to convert this into a string properly
//        loadExternalUrl(url)
//        listener.ignore()
//    }
}
