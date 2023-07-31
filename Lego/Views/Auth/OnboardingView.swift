//
//  OnboardingView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 29/07/2023.
//

import SwiftUI

struct OnboardingView: View {
    enum Path: View {
        case signIn
        case signUp

        var body: some View {
            switch self {
            case .signIn:
                SignInView()
            case .signUp:
                SignUpView()
            }
        }
    }

    var body: some View {
        NavigationStack{
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

                    NavigationLink(value: Path.signUp, label: {ActionButton(title: "GET STARTED")})

                    NavigationLink(value: Path.signIn, label: {ActionButton(title: "LOG IN")})
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
            .frame(maxWidth: .infinity)
            .background(Color._background)
            .navigationDestination(for: Path.self) { path in
                path
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            OnboardingView()
        }
    }
}
