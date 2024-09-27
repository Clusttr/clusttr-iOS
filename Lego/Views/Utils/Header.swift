//
//  Header.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 27/09/2024.
//

import SwiftUI

struct Header: View {
    var title: String

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Text(title)
                    .font(.headline)
                    .foregroundColor(._grey100)
                Spacer()
            }
            .frame(height: 50)
            Divider()
        }
    }
}

#Preview {
    Header(title: "Choose Bank")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color._background)
}
