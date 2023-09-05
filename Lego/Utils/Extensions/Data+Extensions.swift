//
//  Data+Extensions.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 31/08/2023.
//

import Foundation

extension Data {
    public init(hexString: String) {
        self.init([UInt8](hex: hexString))
    }

    public func toHexString() -> String {
        self.bytes.toHexString()
    }
}
