//
//  AccountManager.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 14/08/2023.
//

import Combine
import Foundation
import Solana

class AccountManager: ObservableObject {
    @Published var account: HotAccount
    @Published var solana: Solana
    @Published var balance: Lamports = Lamports(0)

    @Published var cancelBag = Set<AnyCancellable>()

    var publicKeyURL: URL {
        URL(string: "https://solscan.io/account/\(account.publicKey.base58EncodedString)")!
    }

    enum env {
        case dev
        case prod
    }

    init(_ env: env) {
        let envSecretKey = ProcessInfo.processInfo.environment["secret_key"]!
        self.account = (env == .prod) ? try! AccountFactory().account : AccountFactoryDemo(secretKey: envSecretKey).account

        let endpoint = RPCEndpoint.mainnetBetaSolana
        let router = NetworkingRouter(endpoint: endpoint)
        self.solana = Solana(router: router)

        observeAccount()
    }

    func observeAccount() {
        $account
            .sink { account in
                self.setBalance()
            }.store(in: &cancelBag)
    }

    func setBalance() {
        Task {
            do {
                let balance = try await getSolBalance()
                DispatchQueue.main.async {
                    self.balance = balance
                    print(balance.convertToBalance(decimals: 9))
                }
            } catch {
                //throw some error account not valid
                print(error.localizedDescription)
            }
        }
    }
    func getSolBalance() async throws -> Lamports {
        let accountInfo: BufferInfo<AccountInfo> = try await solana.api.getAccountInfo(account: account.publicKey.base58EncodedString)
        return accountInfo.lamports
    }
}
