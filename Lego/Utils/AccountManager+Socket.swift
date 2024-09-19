//
//  AccountManager+Socket.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/09/2024.
//
import Foundation
import Solana

extension AccountManager: SolanaSocketEventsDelegate {
    func connected() {
        guard case let .success(usdcATA) = PublicKey.associatedTokenAddress(
            walletAddress: account.publicKey,
            tokenMintAddress: PublicKey.USDC
        ) else { return }
        usdcSubId = try! solana.socket.accountSubscribe(publickey: usdcATA.base58EncodedString).get()
        solSubId = try! solana.socket.accountSubscribe(publickey: account.publicKey.base58EncodedString).get()
    }

    func accountNotification(notification: Response<BufferInfo<AccountInfo>>) {
        guard let mint = notification.params?.result?.value.data.value?.mint else { return }
        let ata = try! PublicKey.associatedTokenAddress(
            walletAddress: account.publicKey,
            tokenMintAddress: mint
        ).get()
        Task {
            let balance = try! await solana.api.getTokenAccountBalance(pubkey: ata.base58EncodedString)
            DispatchQueue.main.async {
                self.tokenBalances[mint.base58EncodedString] = balance
                self.usdcBalance = self.tokenBalances[PublicKey.USDC.base58EncodedString]
            }
        }
    }

    func programNotification(notification: Response<ProgramAccount<AccountInfo>>) {
        print("Program Changed")
    }

    func signatureNotification(notification: Response<SignatureNotification>) {
        print("Signature Notification: \(notification))")
    }

    func logsNotification(notification: Response<LogsNotification>) {
        print("Logs: \(String(describing: notification.result))))")
    }

    func unsubscribed(id: String) {
        print("subscription cancelled: id: \(id)")
    }

    func subscribed(socketId: UInt64, id: String) {
        print("Subscription successful: socketId: \(socketId), id: \(id)")
    }

    func disconnected(reason: String, code: UInt16) {
        print("socket disconnected: reason \(reason), code: \(code)")
    }

    func error(error: (any Error)?) {
        print("Socket error: \(error?.localizedDescription ?? "cant find error")")
    }
}
