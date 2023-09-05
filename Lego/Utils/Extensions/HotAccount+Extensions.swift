//
//  HotAccount+Extensions.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 14/08/2023.
//

import Foundation
import Solana

extension HotAccount {
    var base58EncodedSecretKeyString: String {
        return secretKey.base58EncodedString
    }
}

extension String {
    var base58EncodedData: Data {
        let bytes = Base58.decode(self)
        let data = Data(bytes)
        return data
    }
}

extension Data {
    var base58EncodedString: String {
        let bytes = self.bytes
        let string = Base58.encode(bytes)
        return string
    }
}
