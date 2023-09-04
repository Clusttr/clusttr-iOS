//
//  RegisterAccountView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 03/09/2023.
//

import SwiftUI

struct RegisterAccountView: View {
    @ObservedObject var viewModel: RegisterAccountViewModel
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack {
            AuthHeaderView(title: "Setup Complete",
                           subtitle: "Your account have been successfully create")

            VStack(spacing: 32) {
                VStack(spacing: 8) {
                    Text("Welcome,\n\(viewModel.user.name)")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color._grey100)
                        .padding(.horizontal, 32)

                    Text("Your wallet address have been successfully created")
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color._grey100)
                        .opacity(0.8)
                }

                AddressView(publicKey: viewModel.publicKey)


            }
            .padding(.top, 40)
            .padding(.horizontal, 24)

            Spacer()

            ActionButton(title: "DONE", action: done)
                .padding(24)

        }
        .background(Color._background)
        .navigationBarBackButtonHidden(true)
        .overlay(alignment: .topLeading) {
            DismissButton()
                .offset(y: -24)
        }
        .loading(viewModel.isLoading, loaderType: .regular)
        .task {
            do  {
                viewModel.isLoading = true
                try await viewModel.registerAccount()
                viewModel.isLoading = false
            } catch {
                viewModel.error = error
            }
        }
    }

    func done() {
        appState.loginState = .loggedIn
        appState.authPath = []
    }
}

struct RegisterAccountView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RegisterAccountView(viewModel: RegisterAccountViewModel(user: .demo(),
                                                                    secretKey: .demoSecretData(),
                                                                    accountService: AccountServiceDouble()))
            .environmentObject(AppState())
        }
    }
}

import Solana
class RegisterAccountViewModel: ObservableObject {
    @Published var user: User
    @Published var secretKey: Data
    @Published var publicKey: PublicKey?
    @Published var isLoading = false
    @Published var error: Error?

    let accountService: IAccountService

    init(user: User, secretKey: Data, accountService: IAccountService = AccountServiceDouble()) {
        self.user = user
        self.secretKey = secretKey
        let hotAccount = HotAccount(secretKey: secretKey)
        publicKey = hotAccount?.publicKey
        self.accountService = accountService
    }

    @discardableResult
    func registerAccount() async throws -> String {
        try await accountService.registerAccount(secretKey: secretKey.base58EncodedString)
    }
}

extension Data {
    static func demoSecretData() -> Self {
        let secretKey = ProcessInfo.processInfo.environment[KeyChainConst.SECRET_KEY.rawValue] ?? ""
        return secretKey.base58EncodedData

        
    }
}
