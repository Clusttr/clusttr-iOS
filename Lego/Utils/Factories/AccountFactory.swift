//
//  AccountFactory.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 12/08/2023.
//

import Foundation
import Solana

protocol IAccountFactory {
    var account: HotAccount { get }
}

struct AccountFactory: IAccountFactory {

    let account: HotAccount

    init() throws {
        guard let key: Data = KeyChain.get(key: .SECRET_KEY) else {
            throw AccountError.invalidSecretKey
        }

        guard let account = HotAccount(secretKey: key) else {
            throw AccountError.invalidSecretData
        }
        self.account = account
    }
}

struct AccountFactoryDemo: IAccountFactory {
    let account: HotAccount

    init(secretKey: String) {
        let data = secretKey.base58EncodedData
        self.account = HotAccount(secretKey: data) ?? HotAccount()!
    }
}


enum AccountError: Error {
    case invalidSecretKey
    case invalidSecretData
}
