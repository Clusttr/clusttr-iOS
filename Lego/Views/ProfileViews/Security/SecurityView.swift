//
//  SecurityView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 30/09/2024.
//

import SwiftUI

struct SecurityView: View {
    var onClickMenu: ()-> Void
    @State private var presentPin: Bool = false

    var body: some View {
        VStack {
            Header(title: "Support", leadingView: {
                EmptyView()
            }, trailingView:  {
                Button("", systemImage: "line.3.horizontal", action: onClickMenu)
                    .foregroundColor(._grey100)
                    .fontWeight(.bold)
            })

            listItem(title: "Change Pin") {
                presentPin = true
            }
            .padding(.top, 12)

            Spacer()

        }
        .padding(.top, 50)
        .background(Color._background)
        .sheet(isPresented: $presentPin) {
            ResetPinView()
                .presentationDetents([.height(250)])
        }
    }
}

@ViewBuilder
func listItem(title: String, action: @escaping ()-> Void) -> some View {
    Button (action: action) {
        VStack(alignment: .leading) {
            Text(title)
                .font(.callout)
            Divider()
        }
        .padding(.horizontal, 16)
        .foregroundColor(Color._grey100)
    }
}

#Preview {
    SecurityView() { }
}
