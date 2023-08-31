//
//  AccountError.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 31/08/2023.
//

import Foundation

enum AccountError: Error {
    case invalidSecretKey
    case invalidSecretData
    case invalidWeb3Instance
    case failedToGetUserInfo
}
