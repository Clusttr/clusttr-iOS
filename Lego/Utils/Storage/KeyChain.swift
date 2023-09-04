//
//  KeyChain.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 06/08/2023.
//

import Foundation
import KeychainSwift

enum AuthError: Error {
    case wrongPin
}

struct KeyChain {
    private static let keychain = KeychainSwift()

    @discardableResult
    public static func set(key: KeyChainConst, value: String) -> Bool {
        keychain.set(value, forKey: key.rawValue)
    }

    @discardableResult
    public static func set(key: KeyChainConst, value: Data) -> Bool {
        keychain.set(value, forKey: key.rawValue)
    }

    public static func get(key: KeyChainConst) -> String? {
        keychain.get(key.rawValue)
    }

    public static func get(key: KeyChainConst) -> Data? {
        keychain.getData(key.rawValue)
    }
}

public enum KeyChainConst: String {
    case ACCESS_TOKEN = "ACCESS_TOKEN"
    case PIN = "PIN"
    case SECRET_KEY = "SECRET_KEY"
}

import Web3Auth
extension KeyChain {

    public static func set(key: KeyChainConst, value: Web3AuthState) {
        
    }
}
