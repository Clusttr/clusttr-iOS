//
//  AuthPath.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 02/08/2023.
//

import Foundation

enum AuthPath {
//    case createWallet
//    case signIn
//    case signUp
    case web3AuthLogin
    case setupPinAndAccount(secretKey: Data, user: User)
    case registerAccount(secretKey: Data, user: User)
}

extension AuthPath: Hashable {
    var hashValue: Int {
        switch self {
//        case .createWallet:
//            return 0
//        case .signIn:
//            return 1
//        case .signUp:
//            return 2
        case .web3AuthLogin:
            return 0
        case .setupPinAndAccount:
            return 1
        case .registerAccount:
            return 2
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(hashValue)
    }

    static func == (lhs: AuthPath, rhs: AuthPath) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

import SwiftUI

extension AuthPath: View {

    var body: some View {
        switch self {
//        case .createWallet:
//            CreateWalletView()
//        case .signIn:
//            SignInView()
//        case .signUp:
//            SignUpView()
        case .web3AuthLogin:
            Web3AuthLoginView()
        case .setupPinAndAccount(let secretKey, let user):
            SetupPinAndAccountView(viewModel: SetupPinAndAccountViewModel(user: user, secretKey: secretKey))
        case let .registerAccount(secretKey, user):
            RegisterAccountView(viewModel: RegisterAccountViewModel(user: user, secretKey: secretKey))
        }
    }
}
