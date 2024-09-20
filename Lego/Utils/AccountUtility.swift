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
    func getTokenBalances(account: PublicKey, tokens: [PublicKey]) async -> [String: TokenAccountBalance]
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

    func getTokenBalances(account: PublicKey, tokens: [PublicKey]) async -> [String : TokenAccountBalance] {
        await withTaskGroup(of: (String, TokenAccountBalance).self) { group in
            let solana = AccountManager.getSolana()
            var balances: [String: TokenAccountBalance] = [:]
            for token in SupportedFungibleToken.allCases.map(\.pubkey) {
                group.addTask {
                    let ata = try! PublicKey.associatedTokenAddress(
                        walletAddress: account,
                        tokenMintAddress: token
                    ).get()
                    let balance = try! await solana.api.getTokenAccountBalance(pubkey: ata.base58EncodedString)
                    return (token.base58EncodedString, balance)
                }
            }

            for await balance in group {
                balances[balance.0] = balance.1
            }
            return balances
        }
    }
}

class AccountUtilityDouble: IAccountUtility {
    func getATA(tokenMint: PublicKey, user: PublicKey?, userAccount: HotAccount) async throws -> PublicKey {
        try? await Task.sleep(for: .seconds(3))
        return PublicKey(string: "9831HW6Ljt8knNaN6r6JEzyiey939A2me3JsdMymmz5J")!
    }

    func getTokenBalances(account: PublicKey, tokens: [PublicKey]) async -> [String : TokenAccountBalance] {
        try? await Task.sleep(for: .seconds(3))
        return tokens.reduce(into: [:]) { result, pubkey in
            result[pubkey.base58EncodedString] = TokenAccountBalance.create(
                uiAmount: 100.5,
                amount: "100500",
                decimals: 2,
                uiAmountString: "100.5"
            )!
        }
    }
}

import Fakery
extension TokenAccountBalance {
    static func create(uiAmount: Double, amount: String, decimals: Int, uiAmountString: String) -> TokenAccountBalance?  {
        let jsonData = """
        {
            "uiAmount": \(uiAmount), 
            "amount": \(amount),
            "decimals": \(decimals),
            "uiAmountString": \(uiAmountString)
        }
        """.data(using: .utf8)!
        return try! JSONDecoder().decode(TokenAccountBalance.self, from: jsonData)
    }
}
