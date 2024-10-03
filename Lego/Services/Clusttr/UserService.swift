//
//  UserService.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 14/10/2023.
//

import Foundation

protocol IUserService {
    func fetchUser() async throws -> UserDTO
    func find(by pubkey: String) async throws -> UserDTO
    func airdrop() async throws -> AirdropDTO

    func fetchBenefactors() async throws -> [UserDTO]
    func addBenefactor(id: String) async throws -> UserDTO

    func fetchBankAccounts() async throws -> [BankAccountDTO]
    func addBankAccount() async throws -> BankAccountDTO
    func deleteBankAccount(id: String, pin: String) async throws -> BankAccountDTO

    func resetPin(pin: String, newPin: String) async throws -> UserDTO
}

extension IUserService {
    static func create() -> IUserService {
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            UserServiceDouble()
        } else {
            UserService()
        }
    }
}

struct UserService: IUserService {
    func fetchUser() async throws -> UserDTO {
        return try await URLSession.shared.request(path: ClusttrAPIs.user, httpMethod: .get)
    }

    func find(by pubkey: String) async throws -> UserDTO {
        return try await URLSession.shared.request(
            path: ClusttrAPIs.findUser,
            httpMethod: .get,
            queryItems: [URLQueryItem(name: "publicKey", value: pubkey)]
        )
    }

    func airdrop() async throws -> AirdropDTO {
        return try await URLSession.shared.request(path: ClusttrAPIs.airdrop, httpMethod: .post)
    }

    func fetchBenefactors() async throws -> [UserDTO] {
        return try await URLSession.shared.request(path: ClusttrAPIs.benefactor, httpMethod: .get)
    }

    func addBenefactor(id: String) async throws -> UserDTO {
        return try await URLSession.shared.request(
            path: ClusttrAPIs.benefactor + "/\(id)",
            httpMethod: .post
        )
    }

    func fetchBankAccounts() async throws -> [BankAccountDTO] {
        return try await URLSession.shared.request(path: ClusttrAPIs.banks, httpMethod: .get)
    }

    func addBankAccount() async throws -> BankAccountDTO {
        return try await URLSession.shared.request(path: ClusttrAPIs.banks, httpMethod: .post)
    }

    func deleteBankAccount(id: String, pin: String) async throws -> BankAccountDTO {
        return try await URLSession.shared.request(path: ClusttrAPIs.banks, httpMethod: .delete)
    }

    func resetPin(pin: String, newPin: String) async throws -> UserDTO {
        let req = ResetPinReqDTO(oldPin: pin, newPin: newPin)
        let data = try JSONEncoder().encode(req)
        return try await URLSession.shared.request(path: ClusttrAPIs.pin, httpMethod: .post, body: data)
    }
}

struct UserServiceDouble: IUserService {
    func fetchUser() async throws -> UserDTO {
        try? await Task.sleep(for: .seconds(3))
        return .mock()
    }

    func find(by pubkey: String) async throws -> UserDTO {
        try? await Task.sleep(for: .seconds(3))
        return .mock()
    }

    func airdrop() async throws -> AirdropDTO {
        try? await Task.sleep(for: .seconds(3))
        return .demo()
    }

    func fetchBenefactors() async throws -> [UserDTO] {
        try? await Task.sleep(for: .seconds(2))
        return [.mock(), .mock(), .mock(), .mock(), .mock()]
    }

    func addBenefactor(id: String) async throws -> UserDTO {
        try? await Task.sleep(for: .seconds(3))
        return .mock()
    }

    func fetchBankAccounts() async throws -> [BankAccountDTO] {
        try? await Task.sleep(for: .seconds(1))
        return [.mock(), .mock(), .mock()]
    }

    func addBankAccount() async throws -> BankAccountDTO {
        try? await Task.sleep(for: .seconds(1))
        return .mock()
    }

    func deleteBankAccount(id: String, pin: String) async throws -> BankAccountDTO {
        try? await Task.sleep(for: .seconds(1))
        return .mock(id: id)
    }

    func resetPin(pin: String, newPin: String) async throws -> UserDTO {
        try? await Task.sleep(for: .seconds(3))
        return .mock()
    }
}
