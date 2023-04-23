//
//  ProjectCard.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 22/04/2023.
//

import SwiftUI

struct ProjectCard: View {
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            Image.wallpaper
                .resizable()
                .frame(height: 200)
                .overlay {
                    ZStack {
                        LinearGradient(colors: [.clear, .black.opacity(0.5)], startPoint: .top, endPoint: .bottom)
                        VStack(alignment: .leading) {
                            Spacer()
                            HStack {
                                VStack(alignment: .leading, spacing: 1) {
                                    Text("Grand Living Project 2022")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white.opacity(0.9))
                                        .frame(width: screenWidth * 0.7, alignment: .leading)

                                    Text("By Kayla's Court")
                                        .font(.caption2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white.opacity(0.6))
                                }

                                Spacer()

                                Image.ape
                                    .resizable()
                                    .frame(width: 45, height: 45)
                                    .clipShape(Circle())
                                    .overlay {
                                        Circle()
                                            .strokeBorder(.white.opacity(0.75), lineWidth: 0.5)
                                    }
                            }

                            Text("Freshly developed from the enbloc of Tulip Garden, it comprises a total of 638 residential units over 12 storeys...")
                                .font(.footnote)
                                .lineLimit(3)
                                .foregroundColor(.white.opacity(0.8))
                                .frame(width: screenWidth * 0.8, alignment: .leading)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(16)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .frame(height: 200)
    }
}

struct ProjectCard_Previews: PreviewProvider {
    static var previews: some View {
        ProjectCard()
    }
}
