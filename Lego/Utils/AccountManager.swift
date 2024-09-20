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

//        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
//            self.solana.socket.start(delegate: self)
//
//        }

//        Task {
//            let balances = await self.accountUtility.getTokenBalances(account: account.publicKey, tokens: SupportedFungibleToken.allCases.map(\.pubkey))
//            DispatchQueue.main.async {
//                self.tokenBalances = balances
//                self.usdcBalance = balances[PublicKey.USDC.base58EncodedString]
//            }
//        }
    }

    static func create() -> AccountManager {
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            AccountManager.mock()
        } else {
            AccountManager(
                accountFactory: try! AccountFactory(),
                transactionUtility: TransactionUtility(),
                accountUtility: AccountUtility()
            )
        }
    }

    static func getSolana() -> Solana {
        let endpoint = RPCEndpoint(
            url: URL(string: "https://devnet.helius-rpc.com/?api-key=d2a5d651-c00a-4072-a7d8-9e760f9666e6")!,
            urlWebSocket: URL(string: "wss://devnet.helius-rpc.com/?api-key=d2a5d651-c00a-4072-a7d8-9e760f9666e6")!,
            network: .devnet
        ) //RPCEndpoint.devnetSolana
        let router = NetworkingRouter(endpoint: endpoint)
        return Solana(router: router)
    }

    //MARK: Set Sol Balance
    private func setBalances() {
        Task {
            do {
                let balance = try await solana.api.getBalance(account: account.publicKey.base58EncodedString)
                let lamports = Lamports(balance)
                let balances = await accountUtility.getTokenBalances(account: account.publicKey, tokens: SupportedFungibleToken.allCases.map(\.pubkey))
                DispatchQueue.main.async {
                    self.balance = lamports
                    self.tokenBalances = balances
                }
            } catch {
                print(error)
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

    static func mock() -> AccountManager {
        AccountManager(accountFactory: AccountFactoryDemo(),
                       transactionUtility: TransactionUtilityDouble(),
                       accountUtility: AccountUtilityDouble())
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

//public extension TokenAccountBalance {
//    init() {
//        let balance = TokenAmountBal(amount: "100_000_000", decimals: 6)
//        let encoder = JSONEncoder()
//        let value = try! encoder.encode(balance)
//        try! self.init(from: value as! Decoder)
//    }
//}

//struct TokenAmountBal: Codable, Hashable, Equatable {
//    let uiAmount: Float64?
//    let amount: String
//    let decimals: UInt8?
//    let uiAmountString: String?
//
//    init(amount: String, decimals: UInt8?) {
//        self.amount = amount
//        self.decimals = decimals
//        let amountUI = Double(amount)! / (pow(10, Double(decimals!)))
//        self.uiAmount = amountUI
//        self.uiAmountString = "\(amountUI)"
//    }
//}
