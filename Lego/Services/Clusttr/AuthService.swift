//
//  AuthService.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 31/08/2023.
//

import Foundation
import Web3Auth

struct TestDTO: Codable, CustomDebugStringConvertible {
    let message: String

    var debugDescription: String {
        message
    }
}

struct AuthService {

    static func test() async throws -> TestDTO {
        return try await URLSession.shared.request(path: ClusttrAPIs.hello, httpMethod: .get)
    }

    func signUp(idToken: String) {
        //let egg = Web3Auth.getEd25519PrivKey(web3Auth)
        //let value =web3Auth.userInfo?.idToken
    }
}
