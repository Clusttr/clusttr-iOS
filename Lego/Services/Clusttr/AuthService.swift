//
//  AuthService.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 31/08/2023.
//

import Foundation
import Web3Auth

protocol IAuthService {
    func login(idToken: String, publicKey: String, pin: String) async throws -> AuthResultDTO
    func web3Login() async throws -> (secretKey: Data, user: User)
}

struct AuthService: IAuthService {

    static func test() async throws -> TestDTO {
        return try await URLSession.shared.request(path: ClusttrAPIs.hello, httpMethod: .get)
    }

    func login(idToken: String, publicKey: String, pin: String) async throws -> AuthResultDTO {
        let data = try JSONEncoder().encode(LoginDTO(idToken: idToken, publicKey: publicKey, pin: pin))
        return try await URLSession.shared.request(path: ClusttrAPIs.login, httpMethod: .post, body: data)
    }

    func web3Login() async throws -> (secretKey: Data, user: User) {
        let web3Auth = try await Web3Auth(
            W3AInitParams(
                clientId: "BEhMD-p5PB698Z1pqW_5yAyIitFw5XbmzuHVojraZ6N2XKdtmbLiGZ_O0A5rv0kOyFX5DqvYf7MvClCt6LZ75qQ",
                network: .testnet,
                redirectUrl: "io.clusttr.app://auth"
            )
        )

        let result = try await web3Auth.login(W3ALoginParams(loginProvider: .APPLE, curve: .ED25519))
        guard let userInfo = result.userInfo else {
            throw APIError.noUserCredential
        }
        return (Data(hexString: web3Auth.getEd25519PrivKey()), User(user: userInfo))
    }
}

struct AuthServiceDouble: IAuthService {
    var isNewUser: Bool?

    func login(idToken: String, publicKey: String, pin: String) async throws -> AuthResultDTO {
        let isNewUser = self.isNewUser ?? Bool.random()
        try? await Task.sleep(for: .seconds(3))
        return AuthResultDTO.demo(isNewUser: isNewUser)
    }

    func web3Login() async throws -> (secretKey: Data, user: User) {
        try? await Task.sleep(for: .seconds(3))
        guard let secretKey = ProcessInfo.processInfo.environment[KeyChainConst.SECRET_KEY.rawValue] else {
            throw AccountError.invalidSecretKey
        }
        return (Data(hexString: secretKey), User.demo())
    }
}
