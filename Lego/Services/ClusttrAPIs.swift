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

    static let baseURL = URL(string: "https://3cc8-2c0f-2a80-52-ea00-589-990d-28e2-30b9.ngrok-free.app")//"https://clusttr.up.railway.app")
    static let hello = ""

    //MARK: AUTH
    static let login = "/auth/login"

    //MARK: ACCOUNT
    static let registerAccount = "/account/register"

    //MARK: ASSET
    static let asset = "/asset"

    //MARK: TOKEN
    static let recentAsset = "/token/recent/asset"

    //MARK: USER
    static let user = "/user"
    static let findUser = "/user/find"
    static let airdrop = "/user/airdrop"
    static let benefactor = "/user/benefactor"
    static let pin = "/user/pin"

    //MARK: BANK
    static let bank = "/bank"
    static let bankDetails = "/bank/details"

    //MARK: BOOKMARK
    static let bookmark = "/bookmark"
}
