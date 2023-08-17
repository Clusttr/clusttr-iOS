//
//  NFTService.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/08/2023.
//

import Foundation

protocol INFTService {
    func fetchNFts() async throws -> [NFT]
}

struct NFTService: INFTService {
    func fetchNFts() async throws -> [NFT] {
        let crossMintAPI = CrossMintAPI()
        return try await crossMintAPI.fetchNFTs().map { NFT.init(nft: $0)}
    }
}

struct NFTServiceDouble: INFTService {
    func fetchNFts() async throws -> [NFT] {
        return NFT.fakeData
    }
}
