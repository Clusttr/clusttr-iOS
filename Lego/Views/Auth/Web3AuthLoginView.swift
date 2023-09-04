//
//  Web3AuthLoginView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 29/08/2023.
//

import SwiftUI
import Web3Auth
import Solana

struct Web3AuthLoginView: View {
    var authService: IAuthService = AuthService()
    @EnvironmentObject var appState: AppState
    @State var error: Error?

    var body: some View {
        VStack {
            AuthHeaderView(title: "Setup Wallet", subtitle: "Secured wallet on the blockchain")

            VStack(spacing: 32) {
                Spacer()

                Button(action: login) {
                    HStack {
                        Image(systemName: "apple.logo")
                        Text("Login")
                    }
                    .actionButtonStyle(disabled: false)
                }
                .padding(24)
            }
            .padding(.bottom, 40)
        }
        .background(Color._background)
        .navigationBarBackButtonHidden(true)
        .overlay(alignment: .topLeading) {
            DismissButton()
                .offset(y: -24)
        }
    }

    func login() {
        Task {
            do {
                let (secret, user) = try await authService.web3Login()
                appState.authPath.append(.setupPinAndAccount(secretKey: secret, user: user))
            } catch {
                print(error)
                self.error = error
            }
        }
    }
}

struct Web3AuthLoginView_Previews: PreviewProvider {
    static var previews: some View {
        Web3AuthLoginView(authService: AuthServiceDouble())
    }
}
