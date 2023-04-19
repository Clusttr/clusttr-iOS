//
//  NFTGrid.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/04/2023.
//

import SwiftUI

struct NFTGrid: View {
    @State var NFTs = NFT.fakeData
    var showBidTime: Bool = true

    let columns = [GridItem(.adaptive(minimum: 150))]
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(NFTs) { item in
                    NFTCard(nft: item, showBidTime: showBidTime)
                }
            }
        }
    }
}

struct NFTList_Previews: PreviewProvider {
    static var previews: some View {
        NFTGrid()
    }
}
