//
//  ProjectCarousel.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 23/04/2023.
//

import SwiftUI

struct ProjectCarousel: View {
    var body: some View {
        TabView {
            ForEach(0 ..< 5) { item in
                ProjectCard()
                    .padding(.horizontal)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 210)
    }
}

struct ProjectCarousel_Previews: PreviewProvider {
    static var previews: some View {
        ProjectCarousel()
    }
}
