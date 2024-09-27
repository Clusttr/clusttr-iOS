//
//  BankService.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 27/09/2024.
//

import SwiftUI

protocol IBankService {
    func getBankAccount(for accountNumber: String, bank: String) async throws -> BankAccountDTO
    func addBankAccount(_ bankAccount: BankAccountReqDTO) async throws -> BankAccountDTO
}

extension IBankService {
    static func create() -> IBankService {
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            BankServiceDouble()
        } else {
            BankService()
        }
    }
}

struct BankService: IBankService {
    func getBankAccount(for accountNumber: String, bank: String) async throws -> BankAccountDTO {
        return try await URLSession.shared.request(path: ClusttrAPIs.bankDetails, httpMethod: .get)
    }

    func addBankAccount(_ bankAccount: BankAccountReqDTO) async throws -> BankAccountDTO {
        return try await URLSession.shared.request(path: ClusttrAPIs.banks, httpMethod: .post)
    }
}

struct BankServiceDouble: IBankService {
    func getBankAccount(for accountNumber: String, bank: String) async throws -> BankAccountDTO {
        try? await Task.sleep(for: .seconds(3))
        return BankAccountDTO.mock()
    }

    func addBankAccount(_ bankAccount: BankAccountReqDTO) async throws -> BankAccountDTO {
        try? await Task.sleep(for: .seconds(3))
        return BankAccountDTO.mock()
    }
}
