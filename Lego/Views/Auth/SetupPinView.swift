//
//  SetupPinView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 03/08/2023.
//

import SwiftUI

struct SetupPinView: View {
    @State private var pin = ""
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack {
            AuthHeaderView(title: "Setup Pin", subtitle: "Extra security for every transaction")

            VStack(spacing: 32) {
                Text("Enter your 4 digit pin")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color._grey100)
                    .padding(.horizontal, 32)
                
                OTPView($pin, size: 4)

            }
            .padding(.top, 40)

            Spacer()

            ActionButton(title: "DONE", disabled: pin.count < 4) {
                KeyChain.set(key: .PIN, value: pin)
//                appState.authPath.append(.createWallet)
            }
            .padding(24)
        }
        .background(Color._background)
        .navigationBarBackButtonHidden(true)
        .overlay(alignment: .topLeading) {
            DismissButton()
                .offset(y: -24)
        }
    }
}

struct SetupPinView_Previews: PreviewProvider {
    static var previews: some View {
        SetupPinView()
            .environmentObject(AppState())
    }
}
