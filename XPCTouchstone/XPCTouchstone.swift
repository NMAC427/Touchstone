//
//  XPCTouchstone.swift
//  XPCTouchstone
//
//  Created by Nicolas Camenisch on 08.02.23.
//

import Foundation

class XPCTouchstone: NSObject, XPCTouchstoneProtocol {
    
    let userDefaults = {
        let teamIdPrefix = Bundle.main.object(forInfoDictionaryKey: "TeamIdentifierPrefix") as! String
        return UserDefaults(suiteName: teamIdPrefix + "Touchstone")!
    }()
    
    @objc func getPasscode(reply: @escaping (String?, Error?) -> Void) {
        guard let executableUD = userDefaults.string(forKey: "yksoft_executable") else {
            reply(nil, YKSoftError.invalidExecutable)
            return
        }
        guard let keyFileUD = userDefaults.string(forKey: "key_file") else {
            reply(nil, YKSoftError.invalidKeyFile)
            return
        }
        
        let executablePath = NSString(string: executableUD).standardizingPath
        let keyFilePath = NSString(string: keyFileUD).standardizingPath
        
        guard FileManager.default.isExecutableFile(atPath: executablePath) else {
            reply(nil, YKSoftError.invalidExecutable)
            return
        }
        guard FileManager.default.isReadableFile(atPath: keyFilePath) else {
            reply(nil, YKSoftError.invalidKeyFile)
            return
        }
        
        let executableURL = URL(fileURLWithPath: executablePath)
        let keyFileURL = URL(fileURLWithPath: keyFilePath)
        
        // Run yksoft to get correct key
        let task = Process()
        task.executableURL = executableURL
        task.arguments = ["-f", keyFileURL.deletingLastPathComponent().path, keyFileURL.lastPathComponent]
        
        let outputPipe = Pipe()
        let errorPipe = Pipe()
        
        task.standardOutput = outputPipe
        task.standardError = errorPipe
        
        do {
            try task.run()
        } catch {
            reply(nil, error)
            return
        }
        
        let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
        let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
        
        let output = String(decoding: outputData, as: UTF8.self)
        let error = String(decoding: errorData, as: UTF8.self)
        
        guard !output.isEmpty else {
            reply(nil, YKSoftError.unknown(error))
            return
        }
        
        reply(output, nil)
    }
}
