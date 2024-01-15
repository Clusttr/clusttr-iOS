//
//  RoundButton.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 01/01/2024.
//

import SwiftUI

struct RoundButton: View {
    var systemName: String
    var action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: systemName)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(12)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.25), radius: 10, x: 5, y: 5)
//                .padding(.top, 32)
        }

    }
}

#Preview {
    RoundButton(systemName: "chevron.left") { }
}
