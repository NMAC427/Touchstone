//
//  Token.swift
//  Touchstone
//
//  Created by Nicolas Camenisch on 24.03.23.
//

import Foundation
import KeychainAccess
import YKSoft

class TokenManager {
    
    private let keychainItemName = "MIT Duo 2FA Token"
    private let keychain = Keychain(
        service: "ch.capslock.Touchstone",
        accessGroup: "F2XKQN9YY8.ch.capslock.Touchstone"
    )
    
    private var token: YKToken? {
        get {
            if let data = keychain[data: self.keychainItemName] {
                return try? JSONDecoder().decode(YKToken.self, from: data)
            }
            return nil
        }
        set {
            let data = try! JSONEncoder().encode(newValue)
            keychain[data: self.keychainItemName] = data
        }
    }
    
    static let shared = TokenManager()
    private init() {}
    
    func generateNewToken() {
        self.token = YKToken.generate()
    }
    
    func generateOTP() -> String? {
        guard let token = self.token else {
            return nil
        }
        
        let otp = token.generateOTP()
        self.token = token // After generating a OTP, the state of the token has changed -> must store to keychain
        return otp
    }
    
    func tokenInfo() -> (publicID: String, privateID: String, aesKey: String)? {
        guard let token = self.token else {
            return nil
        }
        
        return (
            publicID: token.publicID,
            privateID: token.privateID,
            aesKey: token.aesKey
        )
    }
    
}
