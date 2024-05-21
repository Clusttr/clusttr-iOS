//
//  AssetSectionViewModel.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 20/05/2024.
//

import Foundation
import Solana

class AssetSectionViewModel: ObservableObject {
    @Published var nfts: [String] = []
    @Published var bookmarkedNFTs: [String] = []
    @Published var searchWord = ""
    let nftService: INFTService
    let assetService: IAssetService

    init(nftService: INFTService = NFTService(),
         assetService: IAssetService = AssetService())
    {
        self.nftService = nftService
        self.assetService = assetService
    }

    @MainActor
    func fetchNFTs(userPublicKey: PublicKey) async {
        do {
            let result = try await nftService.fetchNFts()
            self.nfts = result.filter({ nft in
                nft.owner == userPublicKey
            }).map(\.id)
        } catch {
            print(error.localizedDescription)
        }
    }

    @MainActor
    func fetchBookmarkedNFT() async {
        do {
            let result = try await assetService.fetchBookmarkedAssets()
            self.bookmarkedNFTs = result
        } catch {
            print(error.localizedDescription)
        }
    }
}
