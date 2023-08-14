//
//  AccountManager.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 14/08/2023.
//

import Foundation
import Solana

class AccountManager: ObservableObject {
    @Published var account: HotAccount
    @Published var solana: Solana

    init(_ env: env) {
        let envSecretKey = ProcessInfo.processInfo.environment["secret_key"]!
        self.account = (env == .prod) ? try! AccountFactory().account : AccountFactoryDemo(secretKey: envSecretKey).account

        let endpoint = RPCEndpoint.mainnetBetaSolana
        let router = NetworkingRouter(endpoint: endpoint)
        self.solana = Solana(router: router)
    }

    enum env {
        case dev
        case prod
    }
}
