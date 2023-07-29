//
//  SignInView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 29/07/2023.
//

import SwiftUI

struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 12) {
                Spacer()
                Text("Sign in to your\naccount")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                Text("Welcome back")
                    .fontWeight(.light)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
            .frame(height: 300)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color._grey)

            VStack(spacing: 24) {

                TextField(text: $email) {
                    Text("Enter email")
                        .font(.callout)
                        .foregroundColor(Color._grey400)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .font(.callout)
                .font(.callout)
                .background(Color._grey800)
                .cornerRadius(8)

                SecureField("Passwords", text: $password)
                    .font(.callout)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .font(.callout)
                    .font(.callout)
                    .foregroundColor(Color._accent)
                    .background(Color._grey800)
                    .cornerRadius(8)

            }
            .padding()
            .padding(.top, 40)
            .foregroundColor(Color._grey2)

            Spacer()

            Button(action: login) {
                Text("LOGIN")
                    .multilineTextAlignment(.center)
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(Color._background)
                    .background {
                        LinearGradient(colors: [Color._accent.opacity(0.9), Color.pink.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    }
                    .cornerRadius(12)
            }
            .padding(24)
        }
        .background(Color._background)
    }

    func login() {

    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
