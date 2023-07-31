//
//  AppState.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 19/04/2023.
//

import Combine
import Foundation

class AppState: ObservableObject {
    @Published var isNavBarHidden = false
    @Published var loginState: AuthState = .loggedOut
    @Published public var path: [NFT] = []
//    @Published var navigationPath: NavigationPath = []

    init() {
        restoreState()
        observeAuthState()
    }

    func restoreState() {
        let value = UserDefaults.standard.string(forKey: "AUTH_STATE") ?? ""
        loginState = AuthState(rawValue: value) ?? AuthState.loggedOut
    }

    @Published var cancelBag = Set<AnyCancellable>()
    func observeAuthState() {
        $loginState
            .sink { state in
                UserDefaults.standard.setValue(state.rawValue, forKey: "AUTH_STATE")
            }
            .store(in: &cancelBag)

    }
}
