//
//  SignUpView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 29/07/2023.
//

import SwiftUI

struct SignUpView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""

    var body: some View {
        VStack {
            AuthHeaderView(title: "Create new\naccount", subtitle: "Fast easy access...")

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

                SecureField("Confirm Passwords", text: $confirmPassword)
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

            ActionButton(title: "CREATE ACCOUNT", action: signup)
            .padding(24)
        }
        .background(Color._background)
    }

    func signup() {

    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
