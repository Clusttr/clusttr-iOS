//
//  BankService.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 27/09/2024.
//

import SwiftUI

protocol IBankService {
    func getBankAccountDetails(for accountNumber: String, bank: String) async throws -> BankAccountDTO
    func addBankAccount(_ bankAccount: AddBankAccountReqDTO) async throws -> BankAccountDTO
    func deleteBankAccount(accountNumber: String, bank: String, pin: String) async throws -> BankAccountDTO
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
    func getBankAccountDetails(for accountNumber: String, bank: String) async throws -> BankAccountDTO {
        let query = [
            URLQueryItem(name: "bank", value: bank),
            URLQueryItem(name: "accountNumber", value: accountNumber)
        ]
        return try await URLSession.shared.request(
            path: ClusttrAPIs.bankDetails,
            httpMethod: .get,
            queryItems: query
        )
    }

    func addBankAccount(_ bankAccount: AddBankAccountReqDTO) async throws -> BankAccountDTO {
        let data = try JSONEncoder().encode(bankAccount)
        return try await URLSession.shared.request(path: ClusttrAPIs.bank, httpMethod: .post, body: data)
    }

    func deleteBankAccount(accountNumber: String, bank: String, pin: String) async throws -> BankAccountDTO {
        let dto = DeleteBankAccountReqDto(accountNumber: accountNumber, bank: bank, pin: pin)
        let data = try JSONEncoder().encode(dto)
        return try await URLSession.shared.request(path: ClusttrAPIs.bank, httpMethod: .delete, body: data)
    }
}

struct BankServiceDouble: IBankService {
    func getBankAccountDetails(for accountNumber: String, bank: String) async throws -> BankAccountDTO {
        try? await Task.sleep(for: .seconds(3))
        return BankAccountDTO.mock()
    }

    func addBankAccount(_ bankAccount: AddBankAccountReqDTO) async throws -> BankAccountDTO {
        try? await Task.sleep(for: .seconds(3))
        return BankAccountDTO.mock()
    }

    func deleteBankAccount(accountNumber: String, bank: String, pin: String) async throws -> BankAccountDTO {
        try? await Task.sleep(for: .seconds(1))
        return .mock()
    }
}
