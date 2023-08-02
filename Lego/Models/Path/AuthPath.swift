//
//  AuthPath.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 02/08/2023.
//

import Foundation

enum AuthPath: Hashable {
    case createWallet(forSignUp: Bool)
    case signIn
    case signUp
}

import SwiftUI

extension AuthPath: View {

    var body: some View {
        switch self {
        case .createWallet(let forSignup):
            CreateWalletView(forSignUp: forSignup)
        case .signIn:
            SignInView()
        case .signUp:
            SignUpView()
        }
    }
}
