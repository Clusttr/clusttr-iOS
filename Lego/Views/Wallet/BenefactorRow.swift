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
            HStack(spacing: 16) {
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
        VStack(spacing: 12) {
            Image.ape
                .resizable()
                .frame(width: 45, height: 45)
                .clipShape(Circle())

            VStack(spacing: 0) {
                Text("Mike")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(._grey100)
                Text("0x123A...456x")
                    .font(.caption2)
                    .foregroundColor(._grey100)
            }
        }
        .frame(width: 96, height: 120)
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
