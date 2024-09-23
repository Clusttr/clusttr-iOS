//
//  UserDTO.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 14/10/2023.
//

import Foundation
import Fakery

struct UserDTO: Codable {
    let id: String
    let name: String
    let email: String
    let profileImage: String
    let pubkey: String
}

extension UserDTO {
    static func demo() -> UserDTO {
        let faker = Faker()
        return UserDTO(id: UUID().uuidString,
                       name: faker.name.name(),
                       email: faker.internet.email(),
                       profileImage: faker.internet.image(),
                       pubkey: "HkkVS92U3WwxZz1VKJ2ocD4S4prjHiKz9EBCaGD2s8Fb")
    }
}
