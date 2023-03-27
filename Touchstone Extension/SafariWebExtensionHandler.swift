//
//  SafariWebExtensionHandler.swift
//  Touchstone Extension
//
//  Created by Nicolas Camenisch on 08.02.23.
//

import SafariServices
import os.log

let SFExtensionMessageKey = "message"

class SafariWebExtensionHandler: NSObject, NSExtensionRequestHandling {
	func beginRequest(with context: NSExtensionContext) {
        let item = context.inputItems[0] as! NSExtensionItem
        let message = item.userInfo?[SFExtensionMessageKey]
        os_log(.default, "Received message from browser.runtime.sendNativeMessage: %@", message as! CVarArg)
        
        func reply(message: Any) {
            let response = NSExtensionItem()
            response.userInfo = [ SFExtensionMessageKey: message ]
            context.completeRequest(returningItems: [response], completionHandler: nil)
        }
        
        // -----------
        
        if (message as? String) == "getPasscode" {
            let otp = TokenManager.shared.generateOTP()
            reply(message: otp)
        } else {
            reply(message: "")
        }
    }
}
