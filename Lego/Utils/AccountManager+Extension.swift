//
//  AccountManager+Extension.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 21/09/2024.
//

import Foundation
import Solana

extension AccountManager {
    static func getSolana() -> Solana {
        let endpoint = RPCEndpoint(
            url: URL(string: "https://devnet.helius-rpc.com/?api-key=d2a5d651-c00a-4072-a7d8-9e760f9666e6")!,
            urlWebSocket: URL(string: "wss://devnet.helius-rpc.com/?api-key=d2a5d651-c00a-4072-a7d8-9e760f9666e6")!,
            network: .devnet
        )
        let router = NetworkingRouter(endpoint: endpoint)
        return Solana(router: router)
    }
}

//@available(iOS 13.0, *)
//@available(macOS 10.15, *)
public extension Action {
    func sendSPLTokens(
        mintAddress: String,
        decimals: Decimals,
        from fromPublicKey: String,
        to destinationAddress: String,
        amount: UInt64,
        allowUnfundedRecipient: Bool = false,
        payer: Account
    ) async throws -> TransactionID {
        try await withCheckedThrowingContinuation { c in
            self.sendSPLTokens(
                mintAddress: mintAddress,
                from: fromPublicKey,
                to: destinationAddress,
                amount: amount,
                allowUnfundedRecipient: allowUnfundedRecipient,
                payer: payer,
                onComplete: c.resume(with:)
            )
        }
    }
}
