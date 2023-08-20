//
//  String+Extensions.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 06/08/2023.
//

import Foundation

extension String {

    func isValidPrivateKey() -> Bool {
        // Private keys are usually hexadecimal strings and have a specific length
        let validLengths = [64, 66] // 32-byte and 33-byte (compressed) private keys
        let hexCharacterSet = CharacterSet(charactersIn: "0123456789abcdefABCDEF")

        // Check length
        guard validLengths.contains(self.count) else {
            return false
        }

        // Check character set
        guard self.rangeOfCharacter(from: hexCharacterSet.inverted) == nil else {
            return false
        }

        return true
    }
}
