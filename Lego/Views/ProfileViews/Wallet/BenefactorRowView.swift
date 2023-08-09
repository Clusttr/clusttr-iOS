//
//  BenefactorRow.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/07/2023.
//

import SwiftUI

struct BenefactorRow: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 18) {
                Image(systemName: "plus")
                    .font(.system(size: 24, design: .rounded))
                    .fontWeight(.semibold)
                    .frame(width: 45, height: 45)
                    .foregroundColor(._grey100)
                    .background {
                        LinearGradient(colors: [Color._accent.opacity(0.7), .pink.opacity(0.4)], startPoint: .topTrailing, endPoint: .bottomLeading)
                    }
                    .clipShape(Circle())
                    .padding(.leading, 16)

                ForEach(0 ..< 5) { item in
                    benefactor()
                        .padding(.vertical, 4)
                }
            }
            .padding(.trailing, 16)
        }
    }

    func benefactor() -> some View {
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

struct BenefactorRow_Previews: PreviewProvider {
    static var previews: some View {
        BenefactorRow()
            .background(Color._background)
    }
}
