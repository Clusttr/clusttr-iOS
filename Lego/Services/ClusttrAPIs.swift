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

    static let baseURL = URL(string: "https://clusttr.up.railway.app")
    static let hello = ""

    //MARK: AUTH
    static let login = "/auth/login"

    //MARK: ACCOUNT
    static let registerAccount = "/account/register"
}
