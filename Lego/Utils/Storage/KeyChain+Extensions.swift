//
//  KeyChain+Extensions.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 06/08/2023.
//

import Foundation

enum AuthError: Error {
    case wrongPin
}

extension KeyChain {

    @discardableResult
    static func setPin(_ pin: String) -> OSStatus {
        KeyChain.save(key: Const.PIN, data: Data(from: pin))
    }

    static func getPin() -> String? {
        guard let data = KeyChain.load(key: Const.PIN) else { return nil }
        return data.to(type: String.self)
    }

    @discardableResult
    static func setPrivateKey(_ privateKey: String) -> OSStatus {
        KeyChain.save(key: Const.PIN, data: Data(from: privateKey))
    }

    static func getPrivateKey(pin: String) throws -> String? {
        let userPin = KeyChain.getPin()
        guard userPin == pin else {
            throw AuthError.wrongPin
        }
        guard let data = KeyChain.load(key: Const.PRIVATE_KEY) else { return nil }
        return data.to(type: String.self)
    }
}

private struct Const {
    static let PIN = "PIN"
    static let PRIVATE_KEY = "PRIVATE_KEY"
}
