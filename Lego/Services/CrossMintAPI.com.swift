//
//  CrossMintAPI.com.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/08/2023.
//

import Foundation

struct CrossMintAPI {
    let baseURL = "https://staging.crossmint.com"
    let nftCollectionId: String = "779b12ed-d76b-4c5e-8c1b-2995e2b736dc"
    let headers = [
      "accept": "application/json",
      "content-type": "application/json",
      "x-client-secret": "sk_test.d9acf6c0.77ff5534923a0e6c10a9544a926ff2ad",
      "x-project-id": "ed95cf48-32d3-4d58-b36e-6e9bee9b084f"
    ]

    func fetchNFTs() async throws -> [NFTModel] {
        let url = URL(string: "\(baseURL)/api/2022-06-09/collections/\(nftCollectionId)/nfts?page=1&perPage=20")!
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let decode = try JSONDecoder().decode([NFTModel].self, from: data)
        return decode
    }
}
