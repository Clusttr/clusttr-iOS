//
//  LoginDTO.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 01/09/2023.
//

import Foundation

struct LoginDTO: Codable {
    let idToken: String
    let publicKey: String
    let pin: String
}
