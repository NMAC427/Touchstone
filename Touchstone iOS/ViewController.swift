//
//  ViewController.swift
//  Touchstone iOS
//
//  Created by Nicolas Camenisch on 26.03.23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var publicIDLabel: UILabel!
    @IBOutlet weak var privateIDLabel: UILabel!
    @IBOutlet weak var aesKeyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideTokenInfo()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appMovedToBackground),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )
    }
    
    @objc func appMovedToBackground() {
        self.hideTokenInfo()
    }
    
    @IBAction func showSecretsPressed(_ sender: Any) {
        self.displayTokenInfo()
    }
    
    @IBAction func generateNewTokenPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Generate new software token", message: "This replaces the old software token. This action can't be undone.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive) {_ in
            TokenManager.shared.generateNewToken()
            self.displayTokenInfo()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }
    
    @IBAction func generateOTPPressed(_ sender: Any) {
        guard let otp = TokenManager.shared.generateOTP() else {
            return
        }
            
        UIPasteboard.general.string = otp
    }
    
    func displayTokenInfo() {
        guard let tokenInfo = TokenManager.shared.tokenInfo() else {
            return
        }
        
        publicIDLabel.text = tokenInfo.publicID
        privateIDLabel.text = tokenInfo.privateID
        aesKeyLabel.text = tokenInfo.aesKey
    }
    
    func hideTokenInfo() {
        publicIDLabel.text = "************"
        privateIDLabel.text = "************"
        aesKeyLabel.text = "********************************"
    }

}

