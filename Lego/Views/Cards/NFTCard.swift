//
//  NFTCard.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/04/2023.
//

import SwiftUI

struct NFTCard: View {
    var nft: NFT
    var showBidTime: Bool = true

    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: nft.image)!) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)

            } placeholder: {
                Image(systemName: "photo")
            }
            .frame(width: 150, height: 200)


            VStack(alignment: .leading) {
//                Text(nft.createdAt, style: .relative)
//                    .font(.roboto(size: 12))
//                    .padding(EdgeInsets(top: 3, leading: 5, bottom: 4, trailing: 7))
//                    .background(Color._grey2)
//                    .cornerRadius(50)
//                    .padding(.top, 7)
//                    .padding(.leading, 6)
//                    .opacity(showBidTime ? 1 : 0)

                Spacer()

                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 4) {
                        Text(nft.name)
                    }

                    HStack {
                        VStack(alignment: .leading) {
                            Text("FLOOR")
                                .font(.robotoMedium(size: 8))
                                .foregroundColor(._grey)

                            Text("\(nft.floorPrice.roundUpString(1)) ETH")
                        }

                        Spacer()

                        VStack(alignment: .leading) {
                            Text("TOTAL VOLUME")
                                .font(.robotoMedium(size: 8))
                                .foregroundColor(._grey)

                            Text("\(nft.totalVolume.roundUpString(1)) ETH")
                        }
                    }
                }
                .font(.robotoMedium(size: 12))
                .foregroundColor(.black)
                .padding(6)
                .background(.white.opacity(0.9))
                .cornerRadius(10)
                .padding(.horizontal, 3)
                .padding(.bottom, 14)
            }
        }
        .frame(width: 150, height: 200)
        .cornerRadius(20)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(.white.opacity(0.25), lineWidth: 1)
        }
    }
}

struct NFTCard_Previews: PreviewProvider {
    static var previews: some View {
        NFTCard(nft: .fakeData[0])
    }
}
