//
//  ActionButton.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 29/07/2023.
//

import SwiftUI

struct ActionButton: View {
    var title: String
    var action: () -> Void
    var body: some View {
        Button(action: action) {
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
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(title: "LOGIN", action: {})
    }
}
