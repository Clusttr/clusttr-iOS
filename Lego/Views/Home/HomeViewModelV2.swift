//
//  HomeViewModelV2.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 14/10/2023.
//

import Foundation
import Solana

class HomeViewModelV2: ObservableObject {
    @Published var nfts: [NFT] = []
    @Published var bookmarkedNfts: [String] = []
    private let assetService: IAssetService

    init(assetService: IAssetService = AssetService()) {
        self.assetService = assetService
    }

    @MainActor
    func fetchRecentToken() async {
        do {
            let assets = try await assetService.fetchAssets()
            nfts = assets.map {
                var value = NFT($0)
                value.isBookmarked = bookmarkedNfts.contains(value.id)
                return value
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    @MainActor
    func fetchBookmarkedAssets() async {
        do {
            let bookmarkedAssets = try await assetService.fetchBookmarkedAssets()
            bookmarkedNfts = bookmarkedAssets
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension Double {
    var kmFormatted: String {

        if self >= 10000, self <= 999999 {
            return String(format: "%.1fK", locale: Locale.current,self/1000).replacingOccurrences(of: ".0", with: "")
        }

        if self > 999999 {
            return String(format: "%.1fM", locale: Locale.current,self/1000000).replacingOccurrences(of: ".0", with: "")
        }

        return String(format: "%.0f", locale: Locale.current,self)
    }
}

let prices: [Double] = [
    100_000,
    65_000,
    45_000,
    120_000
]
