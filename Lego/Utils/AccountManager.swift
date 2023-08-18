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
    @Published var usdcPubKey: PublicKey?

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

        let endpoint = RPCEndpoint.devnetSolana
        let router = NetworkingRouter(endpoint: endpoint)
        self.solana = Solana(router: router)

        observeAccount()
    }

    func observeAccount() {
        $account
            .sink { account in
                self.setBalance()
                self.setUSDCAssociateAccount()
            }.store(in: &cancelBag)
    }

    //MARK: Set Sol Balance
    func setBalance() {
        Task {
            do {
                let balance = try await solana.api.getBalance(account: account.publicKey.base58EncodedString)
                let lamports = Lamports(balance)
                DispatchQueue.main.async {
                    self.balance = lamports
                }
            } catch {
                print(error)
            }
        }
    }


    //MARK: Associate Token Account
    private let USDC_PUBLIC_KEY = PublicKey(string: "4zMMC9srt5Ri5X14GAgXhaHii3GnPAEERYPJgZJDncDU")!
    func setUSDCAssociateAccount() {
        Task {
            do {
                let (_, publicKey) = try await solana.action.getOrCreateAssociatedTokenAccount(owner: account.publicKey,
                                                                                               tokenMint: USDC_PUBLIC_KEY,
                                                                                               payer: account)
                DispatchQueue.main.async {
                    self.usdcPubKey = publicKey
                    self.setUSDCBalance()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    //MARK: Set usdc Balance
    @Published var usdcBalance: TokenAccountBalance?
    func setUSDCBalance() {
        guard let usdcPubKey = usdcPubKey else { return }

        Task {
            do {
                let balance = try await solana.api.getTokenAccountBalance(pubkey: usdcPubKey.base58EncodedString)
                DispatchQueue.main.async {
                    self.usdcBalance = balance
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func getSolBalance() async throws -> Lamports {
        let accountInfo: BufferInfo<AccountInfo> = try await solana.api.getAccountInfo(account: account.publicKey.base58EncodedString)
        return accountInfo.lamports
    }
}