//
//  UserService.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 14/10/2023.
//

import Foundation

protocol IUserService {
    func fetchUser() async throws -> UserDTO
    func airdrop() async throws -> AirdropDTO
}

struct UserService: IUserService {
    func fetchUser() async throws -> UserDTO {
        return try await URLSession.shared.request(path: ClusttrAPIs.user, httpMethod: .get)
    }

    func airdrop() async throws -> AirdropDTO {
        return try await URLSession.shared.request(path: ClusttrAPIs.airdrop, httpMethod: .post)
    }
}

struct UserServiceDouble: IUserService {
    func fetchUser() async throws -> UserDTO {
        try? await Task.sleep(for: .seconds(3))
        return .demo()
    }

    func airdrop() async throws -> AirdropDTO {
        try? await Task.sleep(for: .seconds(3))
        return .demo()
    }
}
