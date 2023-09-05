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
    var profileImage: String?
    var idToken: String?
    var description: String {
        name
    }
}

import Web3Auth
extension User {
    init(user: Web3AuthUserInfo) {
        self.name = user.name ?? ""
        self.email = user.email ?? ""
        self.profileImage = user.profileImage
        self.idToken = user.idToken
    }
}

import Fakery
extension User {
    static func demo() -> Self {
        let faker = Faker()
        return User(name: faker.name.name(),
                    email: faker.internet.email(),
                    profileImage: faker.internet.image(),
                    idToken: faker.lorem.characters(amount: 50))
    }
}
