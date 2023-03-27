//
//  ViewController.swift
//  Touchstone
//
//  Created by Nicolas Camenisch on 08.02.23.
//

import Cocoa
import SafariServices

let extensionBundleIdentifier = "ch.capslock.Touchstone.Extension"

class ViewController: NSViewController {
    
    @IBOutlet weak var statusMessageTextField: NSTextFieldCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load current extension status
        SFSafariExtensionManager.getStateOfSafariExtension(withIdentifier: extensionBundleIdentifier) { (state, error) in
            guard let state = state, error == nil else {
                return
            }

            DispatchQueue.main.async {
                self.statusMessageTextField.title = (
                    state.isEnabled
                    ? "Touchstone’s extension is currently on. You can turn it off in Safari Extensions preferences."
                    : "Touchstone’s extension is currently off. You can turn it on in Safari Extensions preferences."
                )
            }
        }
    }

    @IBAction func openPreferencesPressed(_ sender: Any) {
        SFSafariApplication.showPreferencesForExtension(withIdentifier: extensionBundleIdentifier) { error in
            DispatchQueue.main.async {
                NSApplication.shared.terminate(nil)
            }
        }
    }
    
    @IBAction func configurePressed(_ sender: Any) {
        let appDelegate = NSApp.delegate as? AppDelegate
        appDelegate?.openSettings(sender)
    }
}
