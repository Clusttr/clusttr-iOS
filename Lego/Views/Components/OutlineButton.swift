//
//  OutlineButton.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 16/03/2024.
//

import SwiftUI

struct OutlineButton: View {
    var title: String
    var disabled = false
    var action: (() -> Void)?

    var mainContent: some View {
        Text(title)
            .multilineTextAlignment(.center)
            .fontWeight(.medium)
            .fontDesign(.rounded)
            .foregroundColor(._grey100)
            .frame(height: 50)
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(Color._background)
            .background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(Color._grey400, lineWidth: 1)
            }
    }

    var body: some View {
        if let action = action {
            Button(action: action) {
                mainContent
            }
            .disabled(disabled)
        } else {
            mainContent
        }
    }
}

#Preview {
    OutlineButton(title: "BACK", action: {})
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color._background)
}
