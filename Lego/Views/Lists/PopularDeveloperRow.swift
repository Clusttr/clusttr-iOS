//
//  PopularDeveloperRow.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 23/04/2023.
//

import SwiftUI

struct PopularDeveloperRow: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(0 ..< 5) { _ in
                    NavigationLink(value: Developer()) {
                        DeveloperCard()
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
        }
    }
}

struct PopularDeveloperRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PopularDeveloperRow()
                .navigationDestination(for: Developer.self) { _ in
                    DeveloperProfileView()
                }
        }
        .environmentObject(AppState())
    }
}
