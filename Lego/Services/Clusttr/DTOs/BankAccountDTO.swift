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
    static func mock() -> BankAccountDTO {
        let faker = Faker()
        return BankAccountDTO(
            accountName: faker.name.name(),
            accountNumber: "\(faker.number.randomInt(min: 1000000000, max: 9999999999))",
            bank: faker.bank.name()
        )
    }

    static func mock(accountNumber: String, bank: String) -> BankAccountDTO {
        let faker = Faker()
        return BankAccountDTO(
            accountName: faker.name.name(),
            accountNumber: accountNumber,
            bank: bank
        )
    }
}

struct AddBankAccountReqDTO: Codable {
    let accountName: String
    let accountNumber: String
    let bank: String
    let pin: String
}

struct DeleteBankAccountReqDto: Codable {
    let accountNumber: String
    let bank: String
    let pin: String
}
