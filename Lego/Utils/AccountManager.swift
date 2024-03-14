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

    init(accountFactory: IAccountFactory) {
        account = try! accountFactory.getAccount()
        self.solana = Self.getSolana()

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

    static func tryOutProgram() async throws {
        let solana = Self.getSolana()
        let programs = try await solana.api.getProgramAccounts(publicKey: "SwaPpA9LAaLfeLi3a68M4DjnLqgtticKg6CnyNwgAC8", decodedTo: TokenSwapInfo.self)//"4ghb7LAzcmr5PYNkz2tgyEsPHB7Q7vHtiRfLDiFNoDj6")
//        let program = programs.first
//        print(program.pubkey)
//        print(program.account)
        let _ = programs.first.unsafelyUnwrapped.account.data.value
        print(programs)
    }

//    static func tryAccountManager(newAccount: HotAccount) async throws{
//        let solana = Self.getSolana()
//        //"4ghb7LAzcmr5PYNkz2tgyEsPHB7Q7vHtiRfLDiFNoDj6"
//        let RENT_VAULT = "rent_vault"
//        let programId = Generated.PROGRAM_ID
//        let programAddress = PublicKey.findProgramAddress(seeds: [Data(RENT_VAULT.utf8)], programId: programId!)
//        let recentBlockhash = try! await solana.api.getRecentBlockhash()
//
//
//
//        switch programAddress {
//        case .success(let pda):
//            let secret = "3VXnem4KDbvF1Z7eCZuF7z5sVrmWwTvUkVW1Est9YXjvzZmoNKA8BxVq6z5bQgFbYJFw6hVa8TWxrVT8TpS4osyo"
//            guard let account = HotAccount(secretKey: secret.base58EncodedData) else {
//                throw AccountError.invalidSecretData
//            }
//
//            let secret2 = ProcessInfo.processInfo.environment["SECRET_KEY"] ?? ""
//            print(secret2)
//            print(account.publicKey)
//            print(account.publicKey.base58EncodedString)
//
//            // NA HEREusdc
//            let txInstruction = createRegisterNewAccountInstruction(accounts: RegisterNewAccountInstructionAccounts(newAccount: newAccount.publicKey, rentVault: pda.0))
//            var tx = Transaction(feePayer: account.publicKey, instructions: [txInstruction], recentBlockhash: recentBlockhash)
//            tx.sign(signers: [account, newAccount])
////            tx.partialSign(signers: [newAccount])
//            let txSerialize: Result<Data, Error> = tx.serialize()
//
//
//            switch txSerialize {
//            case .success(let data):
//                let txString = data.base64EncodedString()
//                solana.api.sendTransaction(serializedTransaction: txString) { result in
//                    print(result)
//                }
//            case .failure(let error):
//                print("Serialize erro")
//            }
//
//        case .failure(let failure):
//            print("Failed PDA")
//        }
//
//    }

    func getATA(tokenMint: PublicKey, user: PublicKey? = nil) async throws -> PublicKey {
        let solana = AccountManager.getSolana()
//        Task {
//            solana.action.getOrCreateAssociatedTokenAccount(owner: account.publicKey, tokenMint: tokenMint, payer: account) { result in
//                switch result {
//                case .success(let result):
//                    return result.associatedTokenAddress
//                case .failure(let error):
//                    return error
//                }
//            }
//        }
        let result = try await solana.action.getOrCreateAssociatedTokenAccount(owner: user ?? account.publicKey, tokenMint: tokenMint, payer: account)
        return result.associatedTokenAddress
    }

    func sendTransaction(transaction: TransactionInstruction) async throws -> String {
        let solana = Self.getSolana()
        let recentBlockhash = try await solana.api.getRecentBlockhash()
        var tx = Transaction(feePayer: account.publicKey, recentBlockhash: recentBlockhash)
        _ = tx.sign(signers: [account])
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
}
