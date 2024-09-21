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
    func getSolBalance(account: PublicKey) async throws -> Lamports
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

    func getSolBalance(account: PublicKey) async throws -> Lamports {
        let solana = AccountManager.getSolana()
        let balance = try await solana.api.getBalance(account: account.base58EncodedString)
        return Lamports(balance)
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
        try? await Task.sleep(for: .seconds(1))
        return PublicKey(string: "9831HW6Ljt8knNaN6r6JEzyiey939A2me3JsdMymmz5J")!
    }

    func getSolBalance(account: PublicKey) async throws -> Lamports {
        try? await Task.sleep(for: .seconds(1))
        return Lamports(100500000000)
    }

    func getTokenBalances(account: PublicKey, tokens: [PublicKey]) async -> [String : TokenAccountBalance] {
        try? await Task.sleep(for: .seconds(1))
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
            "uiAmount": 100.5,
            "amount": "100500",
            "decimals": 2,
            "uiAmountString": "100.5"
        }
        """.data(using: .utf8)!
        return try! JSONDecoder().decode(TokenAccountBalance.self, from: jsonData)
    }
}
