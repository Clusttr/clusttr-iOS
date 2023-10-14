//
//  UserService.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 14/10/2023.
//

import Foundation

protocol IUserService {
    func fetchUser() async throws -> UserDTO
}

struct UserService: IUserService {
    func fetchUser() async throws -> UserDTO {
        return try await URLSession.shared.request(path: ClusttrAPIs.user, httpMethod: .get)
    }
}

struct UserServiceDouble: IUserService {
    func fetchUser() async throws -> UserDTO {
        try? await Task.sleep(for: .seconds(3))
        return .demo()
    }
}
