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
    var name: String
    var accountNumber: String
    var bankName: String
}

extension BankAccount {
    init(_ dto: BankAccountDTO) {
        self.id = dto.id
        self.name = dto.name
        self.accountNumber = dto.accountNumber
        self.bankName = dto.bankName
    }
}

extension BankAccount {
    static func mock() -> BankAccount {
        let faker = Faker()
        return BankAccount(
            id: UUID().uuidString,
            name: faker.name.name(),
            accountNumber: "\(6)",
            bankName: faker.bank.name()
        )
    }
}
