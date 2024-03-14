//
//  AccountManager.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 14/08/2023.
//

import Combine
import Foundation
import Solana
//import Generated
import InventoryProgram
import struct Solana.Transaction

class AccountManager: ObservableObject {
    @Published var user: User!
    @Published var account: HotAccount
    @Published var solana: Solana
    @Published var balance: Lamports = Lamports(0)
    @Published var usdcPubKey: PublicKey?
    @Published var error: Error?

    @Published var cancelBag = Set<AnyCancellable>()

    var transactionManager: ITransactionUtility
    var accountUtility: IAccountUtility

    var publicKeyURL: URL {
        URL(string: "https://solscan.io/account/\(account.publicKey.base58EncodedString)=devnet")!
    }

    func assetURL(mintHash: PublicKey) -> URL {
        URL(string: "https://solscan.io/token/\(mintHash.base58EncodedString)?cluster=devnet")!
    }

    enum env {
        case dev
        case prod
    }

    init(accountFactory: IAccountFactory, transactionUtility: ITransactionUtility, accountUtility: IAccountUtility) {
        account = try! accountFactory.getAccount()
        self.solana = Self.getSolana()
        self.transactionManager = transactionUtility
        self.accountUtility = accountUtility

        observeAccount()
    }
    static func getSolana() -> Solana {
        let endpoint = RPCEndpoint.devnetSolana
        let router = NetworkingRouter(endpoint: endpoint)
        return Solana(router: router)
    }

    func setHotAccount() {
        
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

    //MARK: get sol balance
    func getSolBalance() async throws -> Lamports {
        let accountInfo: BufferInfo<AccountInfo> = try await solana.api.getAccountInfo(account: account.publicKey.base58EncodedString)
        return accountInfo.lamports
    }

    //MARK: get account info
    static func getAccountInfo(publicKey: String) async throws -> AccountInfo? {
        let accountInfo: BufferInfo<AccountInfo> = try await Self.getSolana()
            .api.getAccountInfo(account: publicKey)
        return accountInfo.data.value
    }


    func getATA(tokenMint: PublicKey, user: PublicKey? = nil) async throws -> PublicKey {
        try await accountUtility.getATA(tokenMint: tokenMint, user: user, userAccount: account)
    }

    func sendTransaction(transaction: TransactionInstruction) async throws -> String {
        try await transactionManager.sendTransaction(transaction, userAccount: account)
    }

    static func mock() -> AccountManager {
        AccountManager(accountFactory: AccountFactoryDemo(),
                       transactionUtility: TransactionUtilityDouble(),
                       accountUtility: AccountUtilityDouble())
    }
}
