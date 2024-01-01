//
//  SetupPinAndAccountView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 01/09/2023.
//

import SwiftUI

struct SetupPinAndAccountView: View {
    @ObservedObject var viewModel: SetupPinAndAccountViewModel
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

                OTPView($viewModel.pin, size: 4)

            }
            .padding(.top, 40)

            Spacer()

            ActionButton(title: "CONTINUE", disabled: viewModel.pin.count < 4, action: login)
                .padding(24)

        }
        .background(Color._background)
        .navigationBarBackButtonHidden(true)
        .overlay(alignment: .topLeading) {
            DismissButton()
                .offset(y: -24)
        }
        .loading(viewModel.isLoading, loaderType: .regular)

    }

    func login() {
        Task {
            do {
                guard let idToken = viewModel.user.idToken else { return }
                let result = try await viewModel.login(idToken: idToken)

                if (result.isNewUser) {
                    appState.authPath.append(.registerAccount(secretKey: viewModel.secretKey, user: viewModel.user))
                } else {
                    appState.loginState = .loggedIn
                    appState.authPath = []
                }

            } catch {
                print(error.localizedDescription)
                viewModel.error = error
                viewModel.isLoading = false
            }
        }
    }

}

struct SetupPinAndAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SetupPinAndAccountView(viewModel: SetupPinAndAccountViewModel(user: .demo(), secretKey: Data(), authService: AuthServiceDouble()))
            .environmentObject(AppState())
    }
}

