//
//  OnboardingView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 29/07/2023.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationStack(path: $appState.authPath){
            VStack {
                Spacer()
                VStack {
                    Text("Welcome to")
                        .fontWeight(.ultraLight)
                        .foregroundColor(Color._grey100)
                    Text("Clusttr")
                        .font(.pacifico(size: 60))
                        .foregroundColor(Color._grey100)
                }
                Spacer()

                VStack(spacing: 18) {

//                    NavigationLink(value: AuthPath.signUp, label: {ActionButton(title: "GET STARTED")})

                    NavigationLink(value: AuthPath.web3AuthLogin, label: {ActionButton(title: "LOG IN")})
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
            .frame(maxWidth: .infinity)
            .background(Color._background)
            .navigationDestination(for: AuthPath.self) { path in
                path
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .environmentObject(AppState())
    }
}
