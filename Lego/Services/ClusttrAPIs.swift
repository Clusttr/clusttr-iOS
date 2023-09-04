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
        accessToken ?? KeyChain.get(key: .ACCESS_TOKEN) ?? ""
    }

    static let baseURL = URL(string: "https://c291-2c0f-2a80-cf-3100-5ddf-eec5-1e78-930e.ngrok-free.app")
    static let hello = ""

    //MARK: AUTH
    static let login = "/auth/login"

    //MARK: ACCOUNT
    static let registerAccount = "/account/register"
}
