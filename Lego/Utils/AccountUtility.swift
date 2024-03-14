//
//  AccountUtility.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 14/03/2024.
//

import Foundation
import Solana

protocol IAccountUtility {
    func getATA(tokenMint: PublicKey, user: PublicKey?, userAccount: HotAccount) async throws -> PublicKey
}

class AccountUtility: IAccountUtility {
    func getATA(tokenMint: PublicKey, user: PublicKey?, userAccount: HotAccount) async throws -> PublicKey {
        let solana = AccountManager.getSolana()
        //use a try catch to transform the error here
        let result = try await solana.action
            .getOrCreateAssociatedTokenAccount(
                owner: user ?? userAccount.publicKey,
                tokenMint: tokenMint,
                payer: userAccount)
        return result.associatedTokenAddress
    }
}

class AccountUtilityDouble: IAccountUtility {
    func getATA(tokenMint: PublicKey, user: PublicKey?, userAccount: HotAccount) async throws -> PublicKey {
        try? await Task.sleep(for: .seconds(3))
        return PublicKey(string: "9831HW6Ljt8knNaN6r6JEzyiey939A2me3JsdMymmz5J")!
    }
}
