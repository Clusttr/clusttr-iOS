//
//  RegisterWalletView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 29/07/2023.
//

import Solana
import SwiftUI

struct RegisterWalletWithMnemonicView: View {
    @StateObject var viewModel = RegisterWalletWithMnemonicViewModel()
    @EnvironmentObject var appState: AppState

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        VStack {
            AuthHeaderView(title: "Create Wallet", subtitle: "Keep your seed phrase secured")

            VStack {
                //Seed phrase
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(Array(viewModel.seedPhrase.enumerated()), id: \.0) { _, phrase in
                        Text(phrase)
                            .font(.footnote)
                            .foregroundColor(Color._grey100)
                    }
                }
                .padding(.vertical, 16)
                .overlay {
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(lineWidth: 1)
                        .foregroundColor(Color._grey100)
                }
                .padding()

                Button(action: copy) {
                    HStack(spacing: 4) {
                        Text("Copy seed phrase")
                            .font(.footnote)
                        Image(systemName: "square.on.square")
                            .foregroundColor(Color._accent)
                    }
                    .foregroundColor(Color._grey100)
                }

                Button(action: paste) {
                    Text("Do you have your seed phrase?\nclick here to paste")
                        .font(.footnote)
                        .fontWeight(.black)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color._grey100)
                        .padding(.top, 30)
                }

            }
            .padding(.top, 30)

            Spacer()
            ActionButton(title: "Continue",
                         action: {appState.loginState = .loggedIn})
            .padding(24)
        }
        .background(Color._background)
        .navigationBarBackButtonHidden(true)
        .navigationDestination(for: Int.self) {_ in MainView()}
        .overlay(alignment: .topLeading) {
            DismissButton()
                .offset(y: -24)
        }
        .task {
            viewModel.generateKeyPair()
        }
    }

    func copy() {
        UIPasteboard.general.string = viewModel.seedPhrase.joined(separator: " ")
    }

    func paste() {
        let seedPhrase = UIPasteboard.general.string?.split(separator: " ")
            .compactMap { String($0) }
        guard let seedPhrase = seedPhrase, seedPhrase.count > 24 else { return }
        viewModel.seedPhrase = seedPhrase
    }
}

struct RegisterWalletWithMnemonicView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterWalletWithMnemonicView()
            .environmentObject(AppState())
    }
}

class RegisterWalletWithMnemonicViewModel: ObservableObject {

    @Published var seedPhrase: [String] = []

    init() { }

    func generateKeyPair() {
        let mnemonic = Mnemonic()
        seedPhrase = mnemonic.phrase
    }
}
