//
//  IAccountFactory.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 31/08/2023.
//

import Foundation
import Solana

protocol IAccountFactory {
    func getAccount() throws -> HotAccount
}

extension IAccountFactory {
    func getAccount(secretKey: Data) throws -> HotAccount {
        guard let account = HotAccount(secretKey: secretKey) else {
            throw AccountError.invalidSecretData
        }
        return account
    }
}
