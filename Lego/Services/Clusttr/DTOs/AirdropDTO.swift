//
//  AirdropDto.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 19/09/2024.
//

import Foundation
import Fakery


struct AirdropDTO: Codable {
    let amount: Int
    let mint: String
    let txSig: String
}

extension AirdropDTO {
    static func demo() -> AirdropDTO {
        let faker = Faker()
        return .init(
            amount: 100,
            mint: faker.lorem.characters(amount: 12),
            txSig: faker.lorem.characters(amount: 24)
        )
    }
}
