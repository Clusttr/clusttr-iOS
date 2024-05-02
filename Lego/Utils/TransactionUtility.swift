//
//  TransactionManger.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 14/03/2024.
//

import Foundation
import Solana

protocol ITransactionUtility {
    func sendTransaction(_ transaction: TransactionInstruction, userAccount: HotAccount) async throws -> String
    func sendToken(from: PublicKey, to destination: PublicKey, amount: Double, decimals: UInt8, mint: PublicKey, payer: Account) async throws -> String
}

class TransactionUtility: ITransactionUtility {
    
    func sendTransaction(_ transaction: TransactionInstruction, userAccount: HotAccount) async throws -> String {
        let solana = AccountManager.getSolana()
        let recentBlockhash = try await solana.api.getRecentBlockhash()
        var tx = Transaction(feePayer: userAccount.publicKey, recentBlockhash: recentBlockhash)
        _ = tx.sign(signers: [userAccount])
        let txResult = tx.serialize()
        switch txResult {
        case .success(let data):
            let txString = data.base64EncodedString()
            let result = try await solana.api.sendTransaction(serializedTransaction: txString)
            return result
        case .failure(let err):
            throw err
        }
    }

    func sendToken(from: PublicKey,to destination: PublicKey, amount: Double, decimals: UInt8, mint: PublicKey, payer: Account) async throws -> String {
        let solana = AccountManager.getSolana()
        return try await solana.action.sendSPLTokens(mintAddress: mint.base58EncodedString,
                                                     decimals: Decimals(decimals),
                                                     from: from.base58EncodedString,
                                                     to: destination.base58EncodedString,
                                                     amount: UInt64(amount),
                                                     allowUnfundedRecipient: true,
                                                     payer: payer)
    }
}

class TransactionUtilityDouble: ITransactionUtility {
    
    func sendTransaction(_ transaction: TransactionInstruction, userAccount: HotAccount) async throws -> String {
        try? await Task.sleep(for: .seconds(3))
        return "someFakeTransactionHash-1234"
    }

    func sendToken(from: PublicKey, to destination: PublicKey, amount: Double, decimals: UInt8, mint: PublicKey, payer: Account) async throws -> String {
        try? await Task.sleep(for: .seconds(3))
        return "someFakeTransactionHash-1234"
    }
}
