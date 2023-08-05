//
//  CreateWalletView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 02/08/2023.
//

import SwiftUI

struct CreateWalletView: View {
    var forSignUp: Bool
    @StateObject var viewModel = CreateWalletViewModel()

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

                NavigationLink(value: AuthPath.setupPin) {
                    ActionButton(title: "CREATE WALLET")
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
        guard let secretKey = UIPasteboard.general.string, secretKey.count > 24  else { return }
        guard let secretKeyData = Data(base64Encoded: secretKey) else { return }
        guard let hotAccount = HotAccount(secretKey: secretKeyData) else { return }
        viewModel.account = hotAccount
    }

    func next() {

    }
}

struct CreateWalletView_Previews: PreviewProvider {
    static var previews: some View {
        CreateWalletView(forSignUp: false)
    }
}

import Solana
class CreateWalletViewModel: ObservableObject {
    @Published var account: HotAccount?
    var publicKey: PublicKey? {
        account?.publicKey
    }
}
