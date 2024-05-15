//
//  TokenService.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 14/10/2023.
//

import Foundation

protocol IAssetService {
    func fetchAssets() async throws -> [AssetDTO]
    func getBookmarkedAssets() async throws -> [String]
    func bookmark(id: String) async throws -> String
    func unbookmark(id: String) async throws -> String
}

struct AssetService: IAssetService {
    func fetchAssets() async throws -> [AssetDTO]{
        return try await URLSession.shared.request(path: ClusttrAPIs.recentAsset, httpMethod: .get)
    }

    func getBookmarkedAssets() async throws -> [String] {
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
    func fetchAssets() async throws -> [AssetDTO] {
        try? await Task.sleep(for: .seconds(3))
        return [AssetDTO.demo()]
    }

    func getBookmarkedAssets() async throws -> [String] {
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
