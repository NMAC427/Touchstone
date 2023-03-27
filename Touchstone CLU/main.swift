//
//  main.swift
//  Touchstone CLU
//
//  Created by Nicolas Camenisch on 24.03.23.
//

import Foundation

if let token = TokenManager.shared.generateOTP() {
    print(token)
    exit(0)
}

class StandardErrorOutputStream: TextOutputStream {
    func write(_ string: String) {
        let stderr = FileHandle.standardError
        try! stderr.write(contentsOf: string.data(using: .utf8)!)
    }
}

var stderr = StandardErrorOutputStream()
print("Failed to generate OTP", to: &stderr)

