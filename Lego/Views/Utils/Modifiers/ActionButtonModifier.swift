//
//  ActionButtonModifier.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 29/08/2023.
//

import SwiftUI

struct ActionButtonModifier: ViewModifier {
    var disabled: Bool

    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .fontWeight(.medium)
            .fontDesign(.rounded)
            .frame(height: 50)
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(Color._background)
            .background {
                LinearGradient(colors: [Color._accent.opacity(0.9), Color.pink.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .opacity(disabled ? 0.5 : 1)
            }
            .cornerRadius(12)
    }
}

extension View {
    func actionButtonStyle(disabled: Bool) -> some View {
        self
            .modifier(ActionButtonModifier(disabled: disabled))
    }
}

struct ActionButtonModifier_Previews: PreviewProvider {
    static var previews: some View {
        Button {

        } label: {
            Text("Hello world")
        }
        .actionButtonStyle(disabled: Bool.random())
    }
}
