//
//  User.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 30/08/2023.
//

import Foundation

struct User: Codable, CustomStringConvertible, Identifiable {
    var id: String
    var name: String
    var username: String
    var email: String
    var profileImage: String?
    var pubkey: String
}

extension User {
    var description: String {
        name
    }

    var displayName: String {
        if username.count > 9 {
            let x = username.prefix(9)//.prefix(9)
            return "@\(x)..."
        }
        return "@\(username)"
    }

    var profileImageURL: URL {
        URL(string: profileImage ?? "")!
    }
}

import Web3Auth
extension User {
    init(user: Web3AuthUserInfo) {
        self.id = ""
        self.name = user.name ?? ""
        self.username = user.name ?? "" //TODO: pass actual username here
        self.email = user.email ?? ""
        self.profileImage = user.profileImage
        self.pubkey = user.idToken!
    }

    init(_ user: UserDTO) {
        self.id = user.id
        self.name = user.name
        self.username = user.username
        self.email = user.email
        self.profileImage = user.profileImage
        self.pubkey = user.publicKey
    }
}

import Fakery
extension User {
    static func demo() -> Self {
        let faker = Faker()
        return User(
            id: faker.lorem.characters(amount: 24),
            name: faker.name.name(),
            username: faker.name.firstName(),
            email: faker.internet.email(),
            profileImage: faker.internet.image(),
            pubkey: faker.lorem.characters(amount: 24)
        )
    }
}
