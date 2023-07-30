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
            AuthHeaderView(title: "Sign in to your\naccount", subtitle: "Welcome back")

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

            ActionButton(title: "LOGIN", action: login)
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
