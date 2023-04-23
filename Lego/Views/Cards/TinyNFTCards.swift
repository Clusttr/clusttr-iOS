//
//  TinyNFTCards.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 20/04/2023.
//

import SwiftUI

struct TinyNFTCards: View {
    var nft: NFT
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(nft.image)
                .resizable()
                .overlay {
                    LinearGradient(colors: [.clear, .black.opacity(0.7)], startPoint: .top, endPoint: .bottom)
                }

            Text("#\(nft.id)")
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundColor(.white.opacity(0.8))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(.horizontal, 8)
                .padding(.vertical, 6)

            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(nft.name.prefix(10))
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text(nft.location.prefix(10))
                        .font(.caption2)
                        .foregroundColor(.white)
                }

                Spacer()

                Text("100k")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 6)
            .padding(.vertical, 8)
        }
        .frame(width: 120, height: 120)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct TinyNFTCards_Previews: PreviewProvider {
    static var previews: some View {
        TinyNFTCards(nft: NFT.fakeData[0])
    }
}
