//
//  AuthHeaderView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 29/07/2023.
//

import SwiftUI

struct AuthHeaderView: View {
    var title: String
    var subtitle: String
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Spacer()
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .fontDesign(.rounded)
            Text(subtitle)
                .fontWeight(.light)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 20)
        .frame(height: 220)
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(Color._background)
        .background(Color._grey)
    }
}

struct AuthHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AuthHeaderView(title: "Sign in to your\naccount", subtitle: "Welcome back")
    }
}
