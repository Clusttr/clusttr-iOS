//
//  AppState.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 19/04/2023.
//

import Combine
import Foundation
import Solana

class AppState: ObservableObject {
    @Published var isNavBarHidden = false
    @Published var loginState: AuthState = .loggedOut

    //MARK: Paths
    @Published public var path: [NFT] = []
    @Published public var authPath: [AuthPath] = []
    @Published public var developerPath: [DeveloperPath] = []

    @Published var cancelBag = Set<AnyCancellable>()

    init() {
        restoreState()
        observeAuthState()
    }

    func restoreState() {
        loginState = LocalStorage.get(key: .authState) ?? .loggedOut
    }

    func observeAuthState() {
        $loginState
            .sink { state in
                if case .loggedOut = state {
                    LocalStorage.clearAllData()
                }
                LocalStorage.save(key: .authState, value: state)
            }
            .store(in: &cancelBag)
    }
}
