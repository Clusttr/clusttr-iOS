//
//  EnterAmountView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 15/03/2024.
//

import SwiftUI
import Solana

struct EnterAmountView: View {
    enum FocusedField {
        case amount
    }

    @Binding var navPath: NavigationPath
    @Binding var isShowing: Bool
    var pubKey: PublicKey
    var tokenBalance = 40_000
    @State var amount = ""
    @FocusState private var focusedField: FocusedField?

    var body: some View {
        VStack {
            VStack {
                HStack {
                    Button {
                        navPath.removeLast()
                    } label: {
                        Image(systemName: "arrow.backward")
                    }
                    Spacer()
                    Text("Send USD to")
                    Spacer()
                }
                .foregroundColor(Color._grey100)
                .fontWeight(.medium)
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)

            VStack(spacing: 60) {
                AddressView(publicKey: pubKey)

                HStack {
                    TextField(text: $amount) {
                        Text("0")
                            .foregroundStyle(Color.white)
                    }
                    .focused($focusedField, equals: .amount)
                    .keyboardType(.numbersAndPunctuation)
                    .multilineTextAlignment(.trailing)
                    
                    Text("USD")
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(Color._grey400)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .defaultFocus($focusedField, .amount)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .onAppear{
                    focusedField = .amount
                }

                Button(action: setMax) {
                    Text("Max: 40,000.0 USD")
                        .foregroundStyle(Color.white)
                        .fontWeight(.medium)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 24)
                        .background(Color._grey700)
                        .cornerRadius(12)
                }
            }
            .padding(.top, 60)
            Spacer()
            ActionButton(title: "Continue") {
                navPath.append("")
            }
        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color._background)

    }

    func setMax() {
        amount = tokenBalance.formatted()
    }
}

#Preview {
    EnterAmountView(navPath: .constant(NavigationPath()),
                    isShowing: .constant(true),
                    pubKey: PublicKey(string: "9831HW6Ljt8knNaN6r6JEzyiey939A2me3JsdMymmz5J")!)
}
