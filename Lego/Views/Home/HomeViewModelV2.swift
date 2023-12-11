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
    private let assetService: IAssetService

    init(assetService: IAssetService = AssetService()) {
        self.assetService = assetService
    }

    @MainActor
    func fetchRecentToken() async {
        do {
            let assets = try await assetService.fetchAssets()
            nfts = assets.map { asset in
                NFT(id: asset.id,
                    mintHash: PublicKey(string: asset.id)!,
                    owner: PublicKey(string: asset.id)!,
                    name: asset.name,
                    description: asset.description,
                    location: asset.attribute.first(where: {$0.traitType == "address"})?.value ?? "",
                    creator: "",
                    image: asset.image,
                    floorPrice: prices.randomElement()!,
                    totalVolume: 50, //asset.supply,
                    createdAt: Date(),
                    assetModels: asset.files.map{ AssetModel(file: $0) },
                    transactions: Transaction.data,
                    valuations: Valuation.data,
                    bedroom: Double(asset.attribute.first(where: {$0.traitType == "bedroom"})?.value ?? "0"),
                    bathrooms: Double(asset.attribute.first(where: {$0.traitType == "bathrooms"})?.value ?? "0"),
                    area: Double(asset.attribute.first(where: {$0.traitType == "area"})?.value ?? "0")
                )
            }
            print(nfts)
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
