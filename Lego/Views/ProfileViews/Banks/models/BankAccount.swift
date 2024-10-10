//
//  BankAccount.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 26/09/2024.
//

import Fakery
import Foundation

struct BankAccount: Identifiable {
    var id: String
    var accountName: String
    var accountNumber: String
    var bank: String
}

extension BankAccount {
    init(_ dto: BankAccountDTO) {
        self.id = dto.id
        self.accountName = dto.accountName
        self.accountNumber = dto.accountNumber
        self.bank = dto.bank
    }
}

extension BankAccount {
    static func mock() -> BankAccount {
        let faker = Faker()
        return BankAccount(
            id: UUID().uuidString,
            accountName: faker.name.name(),
            accountNumber: "\(faker.number.randomInt(min: 1000000000, max: 9999999999))",
            bank: faker.bank.name()
        )
    }
}
