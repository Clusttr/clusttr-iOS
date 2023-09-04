//
//  AuthResultDTO.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 01/09/2023.
//

import Foundation

struct AuthResultDTO: Codable {
    let token: String
    let isNewUser: Bool
}

extension AuthResultDTO {
    static func demo(isNewUser: Bool) -> Self {
        AuthResultDTO(
            token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0ZjFmMjJkNTE3YzExYzFmZTE1YTcyMiIsImlhdCI6MTY5MzU3Nzc3NywiZXhwIjoxNjkzNTc3Nzc3fQ.xFrkOXXUgk7ND5Kz8Egn-zzeaUOhS4Rx4hLV1zKgO6w",
            isNewUser: isNewUser
        )
    }
}
