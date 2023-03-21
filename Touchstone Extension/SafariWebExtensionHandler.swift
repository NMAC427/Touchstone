//
//  SafariWebExtensionHandler.swift
//  Touchstone Extension
//
//  Created by Nicolas Camenisch on 08.02.23.
//

import SafariServices
import os.log

import XPCTouchstone


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
            getPasscode() { passcode, error in
                guard let passcode = passcode else {
                    reply(message: [
                        "error": error?.localizedDescription ?? "UNKNOWN ERROR"
                    ])
                    return
                }
                
                reply(message: passcode)
            }
        } else {
            reply(message: "")
        }
    }
    
    func getPasscode(reply: @escaping (String?, Error?) -> Void) {
        let connection = NSXPCConnection(serviceName: "ch.capslock.XPCTouchstone")
        connection.remoteObjectInterface = NSXPCInterface(with: XPCTouchstoneProtocol.self)
        connection.resume()
        
        guard let service = connection.remoteObjectProxyWithErrorHandler({ error in
            reply(nil, error)
        }) as? XPCTouchstoneProtocol else {
            reply(nil, nil)
            return
        }
        
        service.getPasscode() { passcode, error in
            print("Response from XPC service:", passcode, error)
            reply(passcode, error)
        }
    }
    
}
