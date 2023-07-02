//
//  NFTGrid.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/04/2023.
//

import SwiftUI

struct NFTGrid: View {
    var NFTs: [NFT]
    var showBidTime: Bool = true

    let columns = [GridItem(.adaptive(minimum: 150))]
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(NFTs, id: \.id) { nft in
                    NavigationLink {
                        NFTDetailsView(nft: nft)
                    } label: {
                        NFTCard(nft: nft, showBidTime: showBidTime)
                    }
                }
            }
        }
    }
}

struct NFTList_Previews: PreviewProvider {
    static var previews: some View {
        NFTGrid(NFTs: NFT.fakeData, showBidTime: true)
    }
}
