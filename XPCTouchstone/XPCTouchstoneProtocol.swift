//
//  XPCTouchstoneProtocol.swift
//  XPCTouchstone
//
//  Created by Nicolas Camenisch on 08.02.23.
//

import Foundation

/// The protocol that this service will vend as its API. This protocol will also need to be visible to the process hosting the service.
@objc protocol XPCTouchstoneProtocol {
    
    /// Replace the API of this protocol with an API appropriate to the service you are vending.
    func uppercase(string: String, with reply: @escaping (String) -> Void)
}

/*
 To use the service from an application or other process, use NSXPCConnection to establish a connection to the service by doing something like this:

     let connectionToService = NSXPCConnection(serviceName: "ch.capslock.XPCTouchstone")
     connectionToService.remoteObjectInterface = NSXPCInterface(with: XPCTouchstoneProtocol.self)
     connectionToService.resume()

 Once you have a connection to the service, you can use it like this:

     if let proxy = connectionToService.remoteObjectProxy as? XPCTouchstoneProtocol {
         proxy.uppercase(string: "hello") { aString in
             NSLog("Result string was: \(aString)")
         }
     }

 And, when you are finished with the service, clean up the connection like this:

     connectionToService.invalidate()
*/
