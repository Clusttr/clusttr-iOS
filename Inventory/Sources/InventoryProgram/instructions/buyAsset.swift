/**
 * This code was GENERATED using the solita package.
 * Please DO NOT EDIT THIS FILE, instead rerun solita to update it or write a wrapper to add functionality.
 *
 * See: https://github.com/metaplex-foundation/solita-swift
 */
import Foundation
import Beet
import Solana

/**
 * @category Instructions
 * @category BuyAsset
 * @category generated
 */
public struct BuyAssetInstructionArgs{
    let instructionDiscriminator: [UInt8] /* size: 8 */
    let amount: UInt64

    public init(
        instructionDiscriminator: [UInt8] /* size: 8 */ = buyAssetInstructionDiscriminator,
        amount: UInt64
    ) {
        self.instructionDiscriminator = instructionDiscriminator
        self.amount = amount
    }
}
/**
 * @category Instructions
 * @category BuyAsset
 * @category generated
 */
public let buyAssetStruct = FixableBeetArgsStruct<BuyAssetInstructionArgs>(
    fields: [
        ("instructionDiscriminator", Beet.fixedBeet(.init(value: .collection(UniformFixedSizeArray<UInt8>(element: .init(value: .scalar(u8())), len: 8))))),
        ("amount", Beet.fixedBeet(.init(value: .scalar(u64()))))
    ],
    description: "BuyAssetInstructionArgs"
)
/**
* Accounts required by the _buyAsset_ instruction
*
* @property [_writable_, **signer**] payer  
* @property [_writable_] payerUsdcAccount  
* @property [_writable_] payerMintAccount  
* @property [_writable_] devUsdcAccount  
* @property [_writable_] inventory  
* @property [_writable_] assetInfo  
* @property [_writable_] mintVault  
* @property [] mint  
* @property [] usdcMint   
* @category Instructions
* @category BuyAsset
* @category generated
*/
public struct BuyAssetInstructionAccounts {
    let payer: PublicKey
    let payerUsdcAccount: PublicKey
    let payerMintAccount: PublicKey
    let devUsdcAccount: PublicKey
    let inventory: PublicKey
    let assetInfo: PublicKey
    let mintVault: PublicKey
    let mint: PublicKey
    let usdcMint: PublicKey
    let systemProgram: PublicKey?
    let tokenProgram: PublicKey?

    public init(
        payer: PublicKey,
        payerUsdcAccount: PublicKey,
        payerMintAccount: PublicKey,
        devUsdcAccount: PublicKey,
        inventory: PublicKey,
        assetInfo: PublicKey,
        mintVault: PublicKey,
        mint: PublicKey,
        usdcMint: PublicKey,
        systemProgram: PublicKey? = nil,
        tokenProgram: PublicKey? = nil
    ) {
        self.payer = payer
        self.payerUsdcAccount = payerUsdcAccount
        self.payerMintAccount = payerMintAccount
        self.devUsdcAccount = devUsdcAccount
        self.inventory = inventory
        self.assetInfo = assetInfo
        self.mintVault = mintVault
        self.mint = mint
        self.usdcMint = usdcMint
        self.systemProgram = systemProgram
        self.tokenProgram = tokenProgram
    }
}

public let buyAssetInstructionDiscriminator = [197, 37, 177, 1, 180, 23, 175, 98] as [UInt8]

/**
* Creates a _BuyAsset_ instruction.
*
* @param accounts that will be accessed while the instruction is processed
  * @param args to provide as instruction data to the program
 * 
* @category Instructions
* @category BuyAsset
* @category generated
*/
public func createBuyAssetInstruction(accounts: BuyAssetInstructionAccounts, 
args: BuyAssetInstructionArgs, programId: PublicKey=PublicKey(string: "8oRGerutEMGTumnzzgxbsCEfLLkghC3cdT6EadZaPh3Q")!) -> TransactionInstruction {

    let data = buyAssetStruct.serialize(
            instance: ["instructionDiscriminator": buyAssetInstructionDiscriminator,
"amount": args.amount])

    let keys: [AccountMeta] = [
        AccountMeta(
            publicKey: accounts.payer,
            isSigner: true,
            isWritable: true
        ),
        AccountMeta(
            publicKey: accounts.payerUsdcAccount,
            isSigner: false,
            isWritable: true
        ),
        AccountMeta(
            publicKey: accounts.payerMintAccount,
            isSigner: false,
            isWritable: true
        ),
        AccountMeta(
            publicKey: accounts.devUsdcAccount,
            isSigner: false,
            isWritable: true
        ),
        AccountMeta(
            publicKey: accounts.inventory,
            isSigner: false,
            isWritable: true
        ),
        AccountMeta(
            publicKey: accounts.assetInfo,
            isSigner: false,
            isWritable: true
        ),
        AccountMeta(
            publicKey: accounts.mintVault,
            isSigner: false,
            isWritable: true
        ),
        AccountMeta(
            publicKey: accounts.mint,
            isSigner: false,
            isWritable: false
        ),
        AccountMeta(
            publicKey: accounts.usdcMint,
            isSigner: false,
            isWritable: false
        ),
        AccountMeta(
            publicKey: accounts.systemProgram ?? PublicKey.systemProgramId,
            isSigner: false,
            isWritable: false
        ),
        AccountMeta(
            publicKey: accounts.tokenProgram ?? PublicKey.tokenProgramId,
            isSigner: false,
            isWritable: false
        )
    ]

    let ix = TransactionInstruction(
                keys: keys,
                programId: programId,
                data: data.0.bytes
            )
    return ix
}