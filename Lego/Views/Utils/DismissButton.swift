//
//  DismissButton.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 08/05/2023.
//

import SwiftUI

struct DismissButton: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState

    var body: some View {
        Button {
            dismiss()
            withAnimation(.easeInOut) {
                appState.isNavBarHidden = false
            }
        } label: {
            Image(systemName: "chevron.left")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(12)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.25), radius: 10, x: 5, y: 5)
                .padding(.top, 32)
                .padding(.leading, 16)
        }

    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        DismissButton()
            .environmentObject(AppState())
    }
}
