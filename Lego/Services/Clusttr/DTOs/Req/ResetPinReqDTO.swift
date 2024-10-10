//
//  ResetPinReq.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 02/10/2024.
//

struct ResetPinReqDTO: Codable {
    let oldPin: String
    let newPin: String
}
