//
//  AccountFactory.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 12/08/2023.
//

import Foundation
import Solana

struct AccountFactory: IAccountFactory {
    private let secretKey: Data

    init() throws {
        guard let key: Data = KeyChain.get(key: .SECRET_KEY) else {
            throw AccountError.invalidSecretKey
        }
        self.secretKey = key
    }

    func getAccount() throws -> HotAccount {
        return try getAccount(secretKey: secretKey)
    }
}

struct AccountFactoryDemo: IAccountFactory {
    private let secretKey: Data

    init(secretKey: String = ProcessInfo.processInfo.environment["secret_key"] ?? "") {
        self.secretKey = secretKey.base58EncodedData
    }

    func getAccount() throws -> HotAccount {
        return try getAccount(secretKey: secretKey)
    }
}
