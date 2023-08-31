//
//  User.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 30/08/2023.
//

import Foundation

struct User: Codable, CustomStringConvertible {
    var name: String
    var email: String
    var description: String {
        name
    }
}

import Web3Auth
extension User {
    init(user: Web3AuthUserInfo) {
        self.name = user.name ?? ""
        self.email = user.email ?? ""
    }
}
