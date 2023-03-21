//
//  SettingsViewController.swift
//  Touchstone
//
//  Created by Nicolas Camenisch on 21.03.23.
//

import Cocoa

class SettingsViewController: NSViewController {

    @IBOutlet weak var executableTextField: NSTextFieldCell!
    @IBOutlet weak var keyFileTextField: NSTextFieldCell!
    
    let userDefaults = {
        let teamIdPrefix = Bundle.main.object(forInfoDictionaryKey: "TeamIdentifierPrefix") as! String
        return UserDefaults(suiteName: teamIdPrefix + "Touchstone")!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let executable = userDefaults.string(forKey: "yksoft_executable") {
            executableTextField.stringValue = executable
        }
        
        if let keyFile = userDefaults.string(forKey: "key_file") {
            keyFileTextField.stringValue = keyFile
        }
    }
    
    
    @IBAction func executableValueChanged(_ sender: Any) {
        userDefaults.set(executableTextField.stringValue, forKey: "yksoft_executable")
    }
    
    @IBAction func keyFileValueChanged(_ sender: Any) {
        userDefaults.set(keyFileTextField.stringValue, forKey: "key_file")
    }
    
}
