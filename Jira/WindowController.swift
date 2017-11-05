//
//  WindowController.swift
//  Jira
//
//  Created by John W. Long on 11/5/17.
//  Copyright (c) 2017 John W. Long. All rights reserved.
//

import Cocoa
import WebKit

class WindowController: NSWindowController {

    @IBOutlet weak var addressBar: NSTextField!
    
    override func windowDidLoad() {
        window?.titleVisibility = .Hidden
    }
    
}
