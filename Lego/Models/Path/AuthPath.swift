//
//  AuthPath.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 02/08/2023.
//

import Foundation

enum AuthPath: Hashable {
    case createWallet
    case signIn
    case signUp
    case setupPin
    case web3AuthLogin
}

import SwiftUI

extension AuthPath: View {

    var body: some View {
        switch self {
        case .createWallet:
            CreateWalletView()
        case .signIn:
            SignInView()
        case .signUp:
            SignUpView()
        case .setupPin:
            SetupPinView()
        case .web3AuthLogin:
            Web3AuthLoginView()
        }
    }
}
