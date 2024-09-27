//
//  BankAccountDTO.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 26/09/2024.
//

import Foundation
import Fakery

struct BankAccountDTO: Codable {
    let id: String
    let name: String
    let accountNumber: String
    let bankName: String
}

extension BankAccountDTO {
    static func mock(id: String = UUID().uuidString) -> BankAccountDTO {
        let faker = Faker()
        return BankAccountDTO(
            id: id,
            name: faker.name.name(),
            accountNumber: "\(6)",
            bankName: faker.bank.name()
        )
    }
}


struct BankAccountReqDTO: Codable {
    let name: String
    let accountNumber: String
    let bankName: String
}
