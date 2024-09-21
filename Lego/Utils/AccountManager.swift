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

enum SupportedFungibleToken: CaseIterable {
    case usdc

    var pubkey: PublicKey {
        switch self {
            case .usdc: return PublicKey.USDC
        }
    }
}

class AccountManager: ObservableObject {
    @Published var user: User!
    @Published var account: HotAccount
    @Published var solana: Solana
    @Published var balance: Lamports = Lamports(0)
    @Published var usdcBalance: TokenAccountBalance?
    @Published var error: Error?
    @Published var cancelBag = Set<AnyCancellable>()
    @Published var tokenBalances: [String: TokenAccountBalance] = [:]

    var transactionManager: ITransactionUtility
    var accountUtility: IAccountUtility

    var usdcPubKey: PublicKey {
        try! PublicKey.associatedTokenAddress(
            walletAddress: account.publicKey,
            tokenMintAddress: PublicKey.USDC
        ).get()
    }

    lazy var accountATAs: [PublicKey] = {
        SupportedFungibleToken.allCases.map { token in
            try! PublicKey.associatedTokenAddress(
                walletAddress: account.publicKey,
                tokenMintAddress: token.pubkey
            ).get()
        }
    }()

    enum env {
        case dev
        case prod
    }

    var usdcSubId = ""
    var solSubId = ""

    private init(accountFactory: IAccountFactory, transactionUtility: ITransactionUtility, accountUtility: IAccountUtility) {
        let account = try! accountFactory.getAccount()
        self.account = account
        self.solana = Self.getSolana()
        self.transactionManager = transactionUtility
        self.accountUtility = accountUtility

        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            self.solana.socket.start(delegate: self)
        }
        setBalances()
    }

    static func create() -> AccountManager {
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            AccountManager(accountFactory: AccountFactoryDemo(),
                           transactionUtility: TransactionUtilityDouble(),
                           accountUtility: AccountUtilityDouble())
        } else {
            AccountManager(
                accountFactory: try! AccountFactory(),
                transactionUtility: TransactionUtility(),
                accountUtility: AccountUtility()
            )
        }
    }

    //MARK: Set Sol Balance
    private func setBalances() {
        Task {
            do {
                let solBalance = try await self.accountUtility.getSolBalance(account: account.publicKey)
                let balances = await self.accountUtility.getTokenBalances(account: account.publicKey, tokens: SupportedFungibleToken.allCases.map(\.pubkey))
                DispatchQueue.main.async {
                    self.balance = solBalance
                    self.tokenBalances = balances
                    self.usdcBalance = balances[PublicKey.USDC.base58EncodedString]
                }
            } catch {
                print(error)
                //TODO: If this fails app shouldn't open
            }
        }
    }


    //MARK: get account info
    static func getAccountInfo(publicKey: String) async throws -> AccountInfo? {
        let accountInfo: BufferInfo<AccountInfo> = try await Self.getSolana()
            .api.getAccountInfo(account: publicKey)
        return accountInfo.data.value
    }

    func sendUSDC(to destination: PublicKey, amount: Double) async throws -> String {
        guard let usdcBalance = tokenBalances[PublicKey.USDC.base58EncodedString],
              let decimals = usdcBalance.decimals else { return "fail"}
        let amount = amount * (pow(10, Double(decimals)))
        return try await transactionManager.sendToken(
            from: usdcPubKey,
            to: destination,
            amount: amount,
            decimals: decimals,
            mint: PublicKey.USDC,
            payer: account
        )
    }

    func getATA(tokenMint: PublicKey, user: PublicKey? = nil) async throws -> PublicKey {
        try await accountUtility.getATA(tokenMint: tokenMint, user: user, userAccount: account)
    }

    func sendTransaction(transaction: TransactionInstruction) async throws -> String {
        try await transactionManager.sendTransaction(transaction, userAccount: account)
    }
}
