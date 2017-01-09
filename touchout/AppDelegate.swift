//
//  AppDelegate.swift
//  touchout
//
//  Created by Nano WANG on 12/19/16.
//  Copyright © 2016 Nano WANG. All rights reserved.
//


import Cocoa

@available(OSX 10.12.2, *)
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    // init touchbar
    NSApplication.shared().isAutomaticCustomizeTouchBarMenuItemEnabled = true
  }

//    func applicationWillTerminate(_ aNotification: Notification) {
//        // Insert code here to tear down your application
//    }
}
