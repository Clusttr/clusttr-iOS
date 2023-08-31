//
//  BaseView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 29/07/2023.
//

import SwiftUI
import Solana

enum AuthState: String, Codable {
    case loggedOut
    case loggedIn
}

struct BaseView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        switch appState.loginState {
        case .loggedOut:
            OnboardingView()
        case .loggedIn:
            MainView()
        }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
            .environmentObject(AppState())
    }
}
