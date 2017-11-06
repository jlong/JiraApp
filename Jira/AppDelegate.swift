//
//  AppDelegate.swift
//  Jira
//
//  Created by John W. Long on 11/5/17.
//  Copyright (c) 2017 John W. Long. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var window: NSWindow!
    
    func applicationWillFinishLaunching(_ notification: Notification) {
        let manager:NSAppleEventManager = NSAppleEventManager.shared()
        manager.setEventHandler(self, andSelector: "applicationHandleUrl:withReplyEvent:", forEventClass: AEEventClass(kInternetEventClass), andEventID: AEEventID(kAEGetURL))
    }
    
    func applicationDidBecomeActive(_ notification: Notification) {
        let app = notification.object as! NSApplication
        window = app.mainWindow
    }
    
    func applicationHandleUrl(_ event: NSAppleEventDescriptor, withReplyEvent replyEvent:NSAppleEventDescriptor) {
        let url = event.paramDescriptor(forKeyword: AEKeyword(keyDirectObject))?.stringValue
        
        if (window != nil) {
            let vc = window.contentViewController as! ViewController
            vc.loadUrl(url!)
        } else {
            print("nil window!")
        }
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

}
