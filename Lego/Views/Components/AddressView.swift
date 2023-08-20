//
//  AddressView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 02/08/2023.
//

import SwiftUI
import Solana

struct AddressView: View {
    private var key: String

    init(_ address: String) {
        key = ""
        key = getShort(address: address)
    }

    init(publicKey: PublicKey?) {
        key = ""
        guard let publicKey = publicKey else { return }
        key = publicKey.short(numOfSymbolsRevealed: 4)
    }

    init(account: HotAccount) {
        key = ""
        self.key = getShort(address: account.publicKey.base58EncodedString)
    }

    private func getShort(address: String?) -> String {
        guard let address = address else { return "..."}
        let prefix = address.prefix(5)
        let suffix = address.suffix(5)
        return "\(prefix)...\(suffix)"
    }
    var body: some View {
        Text(key)
            .font(.caption)
            .foregroundColor(._grey100)
            .padding(.vertical, 6)
            .padding(.horizontal, 16)
            .background {
                LinearGradient(colors: [Color._grey.opacity(0.25),
                                        Color.pink.opacity(0.7),
                                        Color.orange.opacity(0.5),
                                        Color._grey100.opacity(0.25)],
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .opacity(0.3)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AddressView("82HWJJ9Gord5WuLjEiX3DeNvBytMuXSFac8Y6aJgj452")

//            AddressView(account: hotAccount)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color._background)
    }
}

//let data = Data(base64Encoded: "private 0Z1lXh2YiiDGt3PsM6InmgclmgSMyaBDI+Gyf9S7TEs7rFzf3d0EQlBuGeDnphZEMTBNxyOnEtkKDBsNcnDmcg==")
//let hotAccount = HotAccount(secretKey: data)
//private 0Z1lXh2YiiDGt3PsM6InmgclmgSMyaBDI+Gyf9S7TEs7rFzf3d0EQlBuGeDnphZEMTBNxyOnEtkKDBsNcnDmcg==
