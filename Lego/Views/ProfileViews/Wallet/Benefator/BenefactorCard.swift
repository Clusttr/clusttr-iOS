//
//  BenefactorCard.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 23/09/2024.
//

import SwiftUI

struct BenefactorCard: View {
    var body: some View {
        VStack(spacing: 6) {
            Image.ape
                .resizable()
                .frame(width: 30, height: 30)
                .clipShape(Circle())

            VStack(spacing: 0) {
                Text("Mike")
                    .fontWeight(.black)
                Text("0x123A...456x")
                    .fontWeight(.bold)
            }
            .font(.caption2)
            .foregroundColor(._grey100)
            .scaleEffect(0.85)
            .opacity(0.5)
        }
        .frame(width: 85, height: 100)
        .background(Color._grey800)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color._grey700, lineWidth: 1)
        }
    }
}

#Preview {
    BenefactorCard()
}
