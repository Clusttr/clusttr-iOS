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

    init(secretKey: String = "") {
        var secret: String = secretKey
        #if DEBUG
            secret = ProcessInfo.processInfo.environment["SECRET_KEY"] ?? "3VXnem4KDbvF1Z7eCZuF7z5sVrmWwTvUkVW1Est9YXjvzZmoNKA8BxVq6z5bQgFbYJFw6hVa8TWxrVT8TpS4osyo"
        #endif
        print(secretKey)
        self.secretKey = secret.base58EncodedData
    }

    func getAccount() throws -> HotAccount {
        return try getAccount(secretKey: secretKey)
    }
}
