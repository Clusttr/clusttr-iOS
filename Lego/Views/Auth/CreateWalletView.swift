//
//  CreateWalletView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 02/08/2023.
//

import SwiftUI

struct CreateWalletView: View {
    @StateObject var viewModel = CreateWalletViewModel()
    @EnvironmentObject var appState: AppState

    var forSignUp: Bool {
        appState.authPath.first == AuthPath.signUp
    }


    var pasteMessage: String {
        if forSignUp {
            return "Do you have a secret key you would rather use?\nclick here to paste"
        } else {
            return "Click here to paste your secret key"
        }
    }

    var body: some View {
        VStack {
            AuthHeaderView(title: "Setup Wallet", subtitle: "Secured wallet on the blockchain")

            VStack(spacing: 32) {
                Spacer()
                Text("This is your unique wallet address, all assets and funds will be managed on securely using this address")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color._grey100)
                    .padding(.horizontal, 32)

                AddressView(publicKey: viewModel.publicKey)

                Button(action: paste) {
                    Text(pasteMessage)
                        .font(.footnote)
                        .fontWeight(.black)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color._grey100)
                        .padding(.top, 30)
                }
                Spacer()

                ActionButton(title: "Done", disabled: viewModel.account == nil) {
                    guard let account = viewModel.account else { return }
                    KeyChain.set(key: .SECRET_KEY, value: account.secretKey.base64EncodedString())
                    appState.authPath = []
                    appState.loginState = .loggedIn
                }
                .padding(24)
            }
        }
        .background(Color._background)
        .navigationBarBackButtonHidden(true)
        .overlay(alignment: .topLeading) {
            DismissButton()
                .offset(y: -24)
        }
        .task {
            if forSignUp {
                viewModel.account = HotAccount()
            }
        }
    }

    func paste() {
        guard let secretKey = UIPasteboard.general.string, secretKey.isValidPrivateKey()  else {
            print("Not a valid secret key")
            return

        }
        guard let secretKeyData = Data(base64Encoded: secretKey) else { return }
        guard let hotAccount = HotAccount(secretKey: secretKeyData) else { return }
        viewModel.account = hotAccount
    }

    func next() {

    }
}

struct CreateWalletView_Previews: PreviewProvider {
    static var previews: some View {
        CreateWalletView()
            .environmentObject(AppState())
    }
}

import Solana
class CreateWalletViewModel: ObservableObject {
    @Published var account: HotAccount?
    var publicKey: PublicKey? {
        account?.publicKey
    }
}
