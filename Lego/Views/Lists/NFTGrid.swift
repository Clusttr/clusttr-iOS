//
//  NFTGrid.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/04/2023.
//

import SwiftUI

struct NFTGrid: View {
    var NFTs: [String]
    var showBidTime: Bool = true
    @EnvironmentObject var appState: AppState

    let columns = [GridItem(.adaptive(minimum: 150))]
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(NFTs, id: \.self) { id in
                    NavigationLink(value: id) {
                        NFTCard(vm: NFTCardViewModel(assetId: id))
                    }
                }
            }
        }
    }
}

struct NFTList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NFTGrid(NFTs: NFT.fakeData.map(\.id), showBidTime: true)
                .navigationDestination(for: NFT.self) { nft in
                    NFTDetailsView(nft: nft)
                }
        }
        .environmentObject(AppState())
    }
}
