//
//  ClusttrAPIs.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 01/09/2023.
//

import Foundation

struct ClusttrAPIs {
    private static var accessToken: String?
    static func getAccessToken() -> String {
        accessToken ?? KeyChain.get(key: .SECRET_KEY) ?? ""
    }

    static let baseURL = URL(string: "https://9580-2c0f-2a80-cf-3100-a955-82ee-d2b6-3b49.ngrok-free.app")
    static let hello = ""
    static let signUp = ""
    static let login = ""
}
