//
//  RegisterWalletView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 29/07/2023.
//

import Solana
import SwiftUI

struct RegisterWalletView: View {
    @ObservedObject var viewModel = RegisterWalletViewModel()

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
                    ForEach(viewModel.seedPhrase, id: \.self) { phrase in
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
            ActionButton(title: "Continue", action: {})
                .padding(24)
        }
        .background(Color._background)
    }

    func copy() {
        UIPasteboard.general.string = viewModel.seedPhrase.joined(separator: " ")
    }

    func paste() {
        let seedPhrase = UIPasteboard.general.string?.split(separator: " ")
            .compactMap { String($0) }
        guard let seedPhrase = seedPhrase else { return }
        viewModel.seedPhrase = seedPhrase
    }
}

struct RegisterWalletView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterWalletView()
    }
}

class RegisterWalletViewModel: ObservableObject {

    @Published var seedPhrase: [String] = []

    init() {
        generateKeyPair()
    }

    func generateKeyPair() {
        let mnemonic = Mnemonic()
        seedPhrase = mnemonic.phrase
    }
}
