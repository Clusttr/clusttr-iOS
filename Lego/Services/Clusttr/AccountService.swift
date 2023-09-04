//
//  AccountService.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 03/09/2023.
//

import Foundation

protocol IAccountService {
    func registerAccount(secretKey: String) async throws -> String
}

struct AccountService: IAccountService {
    func registerAccount(secretKey: String) async throws -> String {
        return try await URLSession.shared.request(path: ClusttrAPIs.registerAccount, httpMethod: .post)
    }
}

struct AccountServiceDouble: IAccountService {
    func registerAccount(secretKey: String) async throws -> String {
        try? await Task.sleep(for: .seconds(3))
        return "some-random-transaction-id"
    }
}
