//
//  NFTService.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/08/2023.
//

import Foundation

protocol INFTService {
    func mintNFT(createNFTParams: CreateNFTParams) async -> Result<Void, Error>
    func fetchNFts() async throws -> [NFT]
}

struct NFTService: INFTService {
    private let crossMintAPIs = CrossMintAPIs()

    func mintNFT(createNFTParams: CreateNFTParams) async -> Result<Void, Error> {
        do {
            _ = try await crossMintAPIs.mintNFT(params: createNFTParams)
            return Result.success(())
        } catch {
            return .failure(error)
        }
    }

    func fetchNFts() async throws -> [NFT] {
        return try await crossMintAPIs.fetchNFTs().map { NFT.init(nft: $0)}
    }
}

struct NFTServiceDouble: INFTService {
    var mintSuccess: Bool?
    func mintNFT(createNFTParams: CreateNFTParams) async -> Result<Void, Error> {
        let result = Bool.random()
        try? await Task.sleep(for: .seconds(5))
        return (mintSuccess ?? Bool.random()) ? .success(()) : .failure(APIError.unknown)
    }

    func fetchNFts() async throws -> [NFT] {
        return NFT.fakeData
    }
}

enum APIError: Error {
    case unknown
}
