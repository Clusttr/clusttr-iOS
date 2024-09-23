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
    func addBenefactor(id: String) async throws -> UserDTO
}

struct UserService: IUserService {
    func fetchUser() async throws -> UserDTO {
        return try await URLSession.shared.request(path: ClusttrAPIs.user, httpMethod: .get)
    }

    func find(by pubkey: String) async throws -> UserDTO {
        let fullPath = ClusttrAPIs.findUser + "?pubkey=\(pubkey)"
        return try await URLSession.shared.request(path: fullPath, httpMethod: .get)
    }

    func airdrop() async throws -> AirdropDTO {
        return try await URLSession.shared.request(path: ClusttrAPIs.airdrop, httpMethod: .post)
    }

    func addBenefactor(id: String) async throws -> UserDTO {
        let fullPath = ClusttrAPIs.user + "?id=\(id)"
        return try await URLSession.shared.request(path: fullPath, httpMethod: .post)
    }
}

struct UserServiceDouble: IUserService {
    func fetchUser() async throws -> UserDTO {
        try? await Task.sleep(for: .seconds(3))
        return .demo()
    }

    func find(by pubkey: String) async throws -> UserDTO {
        try? await Task.sleep(for: .seconds(3))
        return .demo()
    }

    func airdrop() async throws -> AirdropDTO {
        try? await Task.sleep(for: .seconds(3))
        return .demo()
    }

    func addBenefactor(id: String) async throws -> UserDTO {
        try? await Task.sleep(for: .seconds(3))
        return .demo()
    }
}
