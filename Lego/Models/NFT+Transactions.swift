//
//  NFT+Transactions.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 14/03/2024.
//

import Foundation
import InventoryProgram
import Solana

extension NFT {
    func generateBuyInstruction(units: Int, accountManager: AccountManager) async throws -> TransactionInstruction {

        let usdc_mint = PublicKey(string: "4zMMC9srt5Ri5X14GAgXhaHii3GnPAEERYPJgZJDncDU")!
        let userPubkey = accountManager.account.publicKey

        let programId = InventoryProgram.PROGRAM_ID!
        let payerUSDC_ATA = try await accountManager.getATA(tokenMint: usdc_mint)
        let payerMintATA = try await accountManager.getATA(tokenMint: self.mintHash)
        let devUSDC_ATA = try await accountManager.getATA(tokenMint: usdc_mint, user: self.creator)

        let inventory = try PublicKey.findProgramAddress(seeds: [Data("inventory".utf8)], programId: programId).get().0
        let assetInfo = try PublicKey.findProgramAddress(seeds: [Data("assetInfo".utf8), self.mintHash.data], programId: programId).get().0

        let mintVault = try PublicKey.findProgramAddress(seeds: [Data("vault".utf8), self.mintHash.data, userPubkey.data], programId: programId).get().0
        let accounts = BuyAssetInstructionAccounts(payer: userPubkey,
                                                  payerUsdcAccount: payerUSDC_ATA,
                                                  payerMintAccount: payerMintATA,
                                                  devUsdcAccount: devUSDC_ATA,
                                                  inventory: inventory,
                                                  assetInfo: assetInfo,
                                                  mintVault: mintVault,
                                                   mint: self.mintHash,
                                                  usdcMint: usdc_mint)
        let txInstruction = createBuyAssetInstruction(accounts: accounts, args: .init(amount: 3))
        return txInstruction
    }
}
