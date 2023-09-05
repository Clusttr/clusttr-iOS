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
                viewModel.error = error
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


class SetupPinAndAccountViewModel: ObservableObject {
    let user: User
    let secretKey: Data
    let authService: IAuthService

    @Published var pin = ""
    @Published var isLoading = false
    @Published var error: Error?

    init(user: User, secretKey: Data, authService: IAuthService = AuthService()) {
        self.user = user
        self.secretKey = secretKey
        self.authService = authService
    }

    @MainActor
    func login(idToken: String) async throws -> AuthResultDTO {
        isLoading = true
        let result = try await authService.login(idToken: idToken, pin: pin)
        LocalStorage.save(key: .user, value: user)
        KeyChain.set(key: .SECRET_KEY, value: secretKey)
        KeyChain.set(key: .ACCESS_TOKEN, value: result.token)
        KeyChain.set(key: .PIN, value: pin)

        isLoading = false
        return result
    }
}
