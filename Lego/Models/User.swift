//
//  User.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 30/08/2023.
//

import Foundation

struct User: Codable, CustomStringConvertible {
    var id: String
    var name: String
    var email: String
    var profileImage: String?
    var pubkey: String
    var description: String {
        name
    }
}

import Web3Auth
extension User {
    init(user: Web3AuthUserInfo) {
        self.id = ""
        self.name = user.name ?? ""
        self.email = user.email ?? ""
        self.profileImage = user.profileImage
        self.pubkey = user.idToken!
    }

    init(_ user: UserDTO) {
        self.id = user.id
        self.name = user.name
        self.email = user.email
        self.profileImage = user.profileImage
        self.pubkey = user.pubkey
    }
}

import Fakery
extension User {
    static func demo() -> Self {
        let faker = Faker()
        return User(
            id: faker.lorem.characters(amount: 24),
            name: faker.name.name(),
            email: faker.internet.email(),
            profileImage: faker.internet.image(),
            pubkey: faker.lorem.characters(amount: 24)
        )
    }
}
