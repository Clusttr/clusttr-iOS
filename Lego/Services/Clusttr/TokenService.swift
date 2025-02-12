//
//  TokenService.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 14/10/2023.
//

import Foundation

protocol IAssetService {
    func fetchAsset(id: String) async throws -> AssetDTO
    func fetchAssets() async throws -> [AssetDTO]
    func fetchBookmarkedAssets() async throws -> [String]
    func bookmark(id: String) async throws -> String
    func unbookmark(id: String) async throws -> String
}

struct AssetService: IAssetService {
    func fetchAsset(id: String) async throws -> AssetDTO {
        let url = ClusttrAPIs.asset + "/" + id
        return try await URLSession.shared.request(path: url, httpMethod: .get)
    }

    func fetchAssets() async throws -> [AssetDTO]{
        return try await URLSession.shared.request(path: ClusttrAPIs.recentAsset, httpMethod: .get)
    }

    func fetchBookmarkedAssets() async throws -> [String] {
        return try await URLSession.shared.request(path: ClusttrAPIs.bookmark, httpMethod: .get)
    }

    func bookmark(id: String) async throws -> String {
        let url = ClusttrAPIs.bookmark + "/" + id
        print(url)
        return try await URLSession.shared.request(path: url, httpMethod: .post)
    }

    func unbookmark(id: String) async throws -> String {
        return try await URLSession.shared.request(path: ClusttrAPIs.bookmark + "/" + id, httpMethod: .delete)
    }
}

struct AssetServiceDouble: IAssetService {
    func fetchAsset(id: String) async throws -> AssetDTO {
        try? await Task.sleep(for: .seconds(3))
        return AssetDTO.demo()
    }
    func fetchAssets() async throws -> [AssetDTO] {
        try? await Task.sleep(for: .seconds(3))
        return [AssetDTO.demo()]
    }

    func fetchBookmarkedAssets() async throws -> [String] {
        try? await Task.sleep(for: .seconds(3))
        return ["random-asset-pubkey"]
    }

    func bookmark(id: String) async throws -> String {
        try? await Task.sleep(for: .seconds(3))
        return id
    }

    func unbookmark(id: String) async throws -> String {
        try? await Task.sleep(for: .seconds(3))
        return id
    }
}
