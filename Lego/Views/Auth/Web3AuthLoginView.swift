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
    @StateObject var viewModel = Web3AuthLoginViewViewModel()
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
                let state = try await viewModel.login()
                persistData(secretKey: state?.ed25519PrivKey, userInfo: state?.userInfo)

                appState.authPath = []
                appState.loginState = .loggedIn
            } catch {
                self.error = error
            }
        }
    }

    @MainActor
    func persistData(secretKey: String?, userInfo: Web3AuthUserInfo?) {
        guard let secretKey = secretKey else {
            error = AccountError.invalidSecretKey
            return
        }
        guard let userInfo = userInfo else {
            error = AccountError.failedToGetUserInfo
            return
        }
        let secretData = Data(hexString: secretKey)
        let user = User(user: userInfo)

        LocalStorage.save(key: .user, value: user)
        KeyChain.set(key: .SECRET_KEY, value: secretData)
    }

}

struct Web3AuthLoginView_Previews: PreviewProvider {
    static var previews: some View {
        Web3AuthLoginView()
            .environmentObject(AppState())
    }
}

class Web3AuthLoginViewViewModel: ObservableObject {
    var web3Auth: Web3Auth?
    var authState: Web3AuthState?

    @Published var error: Error?
    @Published var account: HotAccount?
    var publicKey: PublicKey? {
        account?.publicKey
    }

    init() {
        Task {
            web3Auth = await Web3Auth(
                W3AInitParams(
                    clientId: "BEhMD-p5PB698Z1pqW_5yAyIitFw5XbmzuHVojraZ6N2XKdtmbLiGZ_O0A5rv0kOyFX5DqvYf7MvClCt6LZ75qQ",
                    network: .testnet
                )
            )
        }

    }

    func login() async throws -> Web3AuthState? {
        let authState = try await web3Auth?.login(W3ALoginParams(loginProvider: .APPLE, curve: .ED25519))
        return authState
        
    }
}
