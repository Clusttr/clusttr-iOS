//
//  BankAccountDTO.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 26/09/2024.
//

import Foundation
import Fakery

struct BankAccountDTO: Codable {
    let accountName: String
    let accountNumber: String
    let bank: String

    var id: String {
        accountNumber + "-" + bank
    }
}

extension BankAccountDTO {
    static func mock(id: String = UUID().uuidString) -> BankAccountDTO {
        let faker = Faker()
        return BankAccountDTO(
            accountName: faker.name.name(),
            accountNumber: "\(faker.number.randomInt(min: 1000000000, max: 9999999999))",
            bank: faker.bank.name()
        )
    }
}

struct AddBankAccountReqDTO: Codable {
    let accountName: String
    let accountNumber: String
    let bank: String
    let pin: String
}
