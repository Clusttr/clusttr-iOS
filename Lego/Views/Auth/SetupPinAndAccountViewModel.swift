//
//  SetupPinAndAccountViewModel.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 15/12/2023.
//

import Foundation
import Solana

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

        registerAccount()
    }

    func registerAccount() {
        Task {
            guard await !isKeyRegistered() else {
                print("account is registered")
                return
            }
            print("Call register account")
            // call register account program
        }
    }

    func isKeyRegistered() async -> Bool {
        do {
            guard let account = HotAccount(secretKey: secretKey) else {
                throw AccountError.invalidSecretData
            }
            let accountInfo = try await AccountManager.getAccountInfo(publicKey: account.publicKey.base58EncodedString)
            return accountInfo != nil
        } catch {
            self.error = error
            return false
        }
    }

    @MainActor
    func login(idToken: String) async throws -> AuthResultDTO {
        isLoading = true
        let publicKey = HotAccount(secretKey: secretKey)!.publicKey.base58EncodedString
        let result = try await authService.login(idToken: idToken, publicKey: publicKey, pin: pin)
        LocalStorage.save(key: .user, value: user)
        KeyChain.set(key: .SECRET_KEY, value: secretKey)
        KeyChain.set(key: .ACCESS_TOKEN, value: result.token)
        KeyChain.set(key: .PIN, value: pin)

        isLoading = false
        return result
    }
}
