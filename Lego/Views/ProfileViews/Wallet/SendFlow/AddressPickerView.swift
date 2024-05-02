//
//  AddressPickerView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 15/03/2024.
//

import SwiftUI
import Solana

struct AddressPickerView: View {
    @Binding var isShowing: Bool
    @State var pubkey = ""
    @State private var navPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navPath) {
            VStack {
                VStack {
                    HStack {
                        Button {
                            isShowing = false
                        } label: {
                            Image(systemName: "xmark")
                        }

                        Spacer()
                        Text("Send USD")
                        Spacer()
                    }
                    .foregroundColor(Color._grey100)
                    .fontWeight(.medium)

                    HStack {
                        TextField(text: $pubkey) {
                            Text("Enter address")
                                .foregroundStyle(Color._grey400)
                        }

                        Button(action: openQRScanner) {
                            Image(systemName: "qrcode.viewfinder")
                                .foregroundColor(Color._grey100)
                        }
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 12)
                    .background(Color._grey800)
                    .cornerRadius(12)
                    .padding(.top)
                }
                .padding(.horizontal, 16)
                .padding(.top, 24)

                Divider()

                VStack(alignment: .leading) {
                    Text("Benefactors")
                        .font(.footnote)
                        .foregroundColor(Color._grey100)
                    BenefactorRow()
                }
                .padding(.top, 32)

                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Recently used")
                            .font(.footnote)
                            .foregroundColor(Color._grey100)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                }
                .padding(.top, 32)

                .padding(.horizontal, 24)
                ActionButton(title: "Continue") {
                    guard let pubkey = PublicKey(string: pubkey) else {
                        print("Not working")
                        return
                    }
                    navPath.append(pubkey)
                }
                .padding(24)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color._background)
            .navigationDestination(for: PublicKey.self) { pubkey in
                EnterAmountView(navPath: $navPath, isShowing: $isShowing, pubKey: pubkey)
            }
        }
    }

    func openQRScanner() {

    }
}

#Preview {
    AddressPickerView(isShowing: .constant(true))
}
