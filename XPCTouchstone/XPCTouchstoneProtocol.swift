//
//  XPCTouchstoneProtocol.swift
//  XPCTouchstone
//
//  Created by Nicolas Camenisch on 08.02.23.
//

import Foundation

enum YKSoftError: Error {
    case unknown(String)
    case invalidExecutable
    case invalidKeyFile
    
    var localizedDescription: String {
        switch self {
        case .unknown(let desc): return desc
        case .invalidExecutable: return "Invalid yksoft executable."
        case .invalidKeyFile: return "Invalid yksoft key file."
        }
    }
}

extension YKSoftError: CustomNSError {
    public var errorUserInfo: [String : Any] {
        return [
            NSLocalizedDescriptionKey: self.localizedDescription
        ]
    }
}

@objc public protocol XPCTouchstoneProtocol {
    func getPasscode(reply: @escaping (String?, Error?) -> Void)
}
