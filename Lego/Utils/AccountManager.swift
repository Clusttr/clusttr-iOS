//
//  AccountManager.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 14/08/2023.
//

import Combine
import Foundation
import Solana
import InventoryProgram
import struct Solana.Transaction

class AccountManager: ObservableObject {
    @Published var user: User!
    @Published var account: HotAccount
    @Published var solana: Solana
    @Published var balance: Lamports = Lamports(0)
    @Published var usdcPubKey = PublicKey(string: "9831HW6Ljt8knNaN6r6JEzyiey939A2me3JsdMymmz5J")!
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
    func setUSDCAssociateAccount() {
        Task {
            do {
                let (_, publicKey) = try await solana.action.getOrCreateAssociatedTokenAccount(owner: account.publicKey,
                                                                                               tokenMint: PublicKey.USDC,
                                                                                               payer: account)
                DispatchQueue.main.async {
                    self.usdcPubKey = publicKey
                    self.setUSDCBalance()
                }
            } catch {
                print(error.localizedDescription)
                self.setUSDCBalance()
            }
        }
    }

    //MARK: Set usdc Balance
    @Published var usdcBalance: TokenAccountBalance?
    func setUSDCBalance() {
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

    func sendToken(to destination: PublicKey, amount: UInt64, decimals: UInt64, mint: PublicKey) async throws -> String {
        return try await transactionManager.sendToken(to: destination,
                                                      amount: amount,
                                                      decimals: decimals,
                                                      mint: mint,
                                                      userAccount: account)
    }

    func sendUSDC(to destination: PublicKey, amount: Double) async throws -> String {
        return try await transactionManager.sendToken(to: destination,
                                                      amount: UInt64(amount),
                                                      decimals: UInt64(amount),
                                                      mint: usdcPubKey,
                                                      userAccount: account)
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

extension PublicKey {
    static let USDC = PublicKey(string: "3es74o8wDr3e78opFkQttaaAbnjsUewM62QLPx2cxZmM")!
}
