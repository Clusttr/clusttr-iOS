//
//  OnboardingView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 29/07/2023.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("Welcome to")
                    .fontWeight(.light)
                    .foregroundColor(Color._grey100)
                Text("Clusttr")
                    .font(.pacifico(size: 50))
                    .foregroundColor(Color._grey100)
            }
            Spacer()

            VStack(spacing: 18) {
                ActionButton(title: "GET STARTED") { }
                ActionButton(title: "LOG IN") { }
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .background(Color._background)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
