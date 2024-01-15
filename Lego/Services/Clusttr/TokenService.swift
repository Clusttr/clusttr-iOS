//
//  TokenService.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 14/10/2023.
//

import Foundation

protocol IAssetService {
    func fetchAssets() async throws -> [AssetDTO]
}

struct AssetService: IAssetService {
    func fetchAssets() async throws -> [AssetDTO]{
        return try await URLSession.shared.request(path: ClusttrAPIs.recentAsset, httpMethod: .get)
    }
}

struct AssetServiceDouble: IAssetService {
    func fetchAssets() async throws -> [AssetDTO] {
        try? await Task.sleep(for: .seconds(3))
        return [AssetDTO.demo()]
    }
}
