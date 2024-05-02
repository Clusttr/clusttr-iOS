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

    func txURL(tx: String) -> URL {
        URL(string: "https://solscan.io/tx/\(tx)?cluster=devnet")!
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

    func sendUSDC(to destination: PublicKey, amount: Double) async throws -> String {
        guard let usdcBalance = usdcBalance, let decimals = usdcBalance.decimals else { return "fail"} // throw error instead
        let amount = amount * (pow(10, Double(decimals)))
        return try await transactionManager.sendToken(from: usdcPubKey,
                                                      to: destination,
                                                      amount: amount,
                                                      decimals: decimals,
                                                      mint: PublicKey.USDC,
                                                      payer: account)
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


@available(iOS 13.0, *)
@available(macOS 10.15, *)
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

public extension TokenAccountBalance {
    init() {
        let balance = TokenAmountBal(amount: "100_000_000", decimals: 6)
        let encoder = JSONEncoder()
        let value = try! encoder.encode(balance)
        try! self.init(from: value as! Decoder)
    }
}

struct TokenAmountBal: Codable, Hashable, Equatable {
    let uiAmount: Float64?
    let amount: String
    let decimals: UInt8?
    let uiAmountString: String?

    init(amount: String, decimals: UInt8?) {
        self.amount = amount
        self.decimals = decimals
        let amountUI = Double(amount)! / (pow(10, Double(decimals!)))
        self.uiAmount = amountUI
        self.uiAmountString = "\(amountUI)"
    }
}
