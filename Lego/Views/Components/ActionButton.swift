//
//  ActionButton.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 29/07/2023.
//

import SwiftUI

struct ActionButton: View {
    var title: String
    var action: (() -> Void)?

    var mainContent: some View {
        Text(title)
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

    var body: some View {
        if let action = action {
            Button(action: action) {
                mainContent
            }
        } else {
            mainContent
        }
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(title: "LOGIN", action: {})
    }
}
