//
//  Header.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 27/09/2024.
//

import SwiftUI

struct Header<Content1: View, Content2: View>: View {
    var title: String
    @ViewBuilder let leadingView: (() -> Content1)?
    @ViewBuilder let trailingView: (() -> Content2)?

    init(
        title: String,
        leadingView: (() -> Content1)? = nil,
        trailingView: (() -> Content2)? = nil
    ) {
        self.title = title
        self.leadingView = leadingView
        self.trailingView = trailingView
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                switch leadingView {
                case .none:
                    EmptyView()
                case .some(let button):
                    button()
                        .padding(.leading, 8)
                }

                Spacer()

                Text(title)
                    .font(.headline)
                    .foregroundColor(._grey100)
                Spacer()

                switch trailingView {
                case .none:
                    EmptyView()
                case .some(let button):
                    button()
                }
            }
            .frame(height: 50)
            Divider()
        }
    }
}

#Preview {
    Header<Text, Text>(title: "Choose Bank")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color._background)
}
