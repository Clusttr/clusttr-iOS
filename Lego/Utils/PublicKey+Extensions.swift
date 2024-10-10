//
//  PublicKey+Extensions.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/09/2024.
//

import Foundation
import Solana

extension PublicKey {
    var accountURL: URL {
        URL(string: "https://solscan.io/account/\(base58EncodedString)=devnet")!
    }

    var assetURL: URL {
        URL(string: "https://solscan.io/asset/\(base58EncodedString)=devnet")!
    }

    static let USDC = PublicKey(string: "3es74o8wDr3e78opFkQttaaAbnjsUewM62QLPx2cxZmM")!

    static func txURL(tx: String) -> URL {
        URL(string: "https://solscan.io/tx/\(tx)?cluster=devnet")!
    }
}
