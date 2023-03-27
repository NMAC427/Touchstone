//
//  SettingsViewController.swift
//  Touchstone
//
//  Created by Nicolas Camenisch on 21.03.23.
//

import Cocoa

class SettingsViewController: NSViewController {

    @IBOutlet weak var publicIDTextField: NSTextFieldCell!
    @IBOutlet weak var privateIDTextField: NSTextFieldCell!
    @IBOutlet weak var aesKeyTextField: NSTextFieldCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideTokenInfo()
    }
    
    override func viewWillAppear() {
        self.hideTokenInfo()
    }
    
    @IBAction func generateNewTokenPressed(_ sender: Any) {
        let alert = NSAlert()
        alert.messageText = "Generate new software token"
        alert.informativeText = "This replaces the old software token. This action can't be undone."
        alert.alertStyle = .critical
        alert.addButton(withTitle: "OK").keyEquivalent = ""
        alert.addButton(withTitle: "Cancel").keyEquivalent = "\r"
        alert.beginSheetModal(for: self.view.window!) { response in
            if (response == .alertFirstButtonReturn) {
                TokenManager.shared.generateNewToken()
                self.displayTokenInfo()
            }
        }
    }
    
    @IBAction func showSecretsPressed(_ sender: Any) {
        self.displayTokenInfo()
    }
    
    @IBAction func generateOTPPressed(_ sender: Any) {
        guard let otp = TokenManager.shared.generateOTP() else {
            return
        }
            
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(otp, forType: .string)
    }
    
    func displayTokenInfo() {
        guard let tokenInfo = TokenManager.shared.tokenInfo() else {
            return
        }
        
        publicIDTextField.title = tokenInfo.publicID
        privateIDTextField.title = tokenInfo.privateID
        aesKeyTextField.title = tokenInfo.aesKey
    }
    
    func hideTokenInfo() {
        publicIDTextField.title = "************"
        privateIDTextField.title = "************"
        aesKeyTextField.title = "********************************"
    }
    
}
