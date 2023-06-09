//
//  AppDelegate.swift
//  Touchstone
//
//  Created by Nicolas Camenisch on 08.02.23.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var settingsWindowController: NSWindowController? = nil

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Override point for customization after application launch.
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    @IBAction func openSettings(_ sender: Any) {
        if settingsWindowController == nil {
            settingsWindowController = NSStoryboard(name: "Main", bundle: .main).instantiateController(withIdentifier: "settings") as? NSWindowController
        }
        
        settingsWindowController?.showWindow(self)
    }
}
