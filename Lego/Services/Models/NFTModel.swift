//
//  NFTModel.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/08/2023.
//

import Foundation

struct NFTModel: Decodable {
    let id: String
    let metadata: Metadata
    let onChain: OnChain
}

struct Metadata: Decodable {
    let name, symbol: String
//    let sellerFeeBasisPoints: Int
    let description: String
    let image: String
//    let attributes: [[String: String]]
    let properties: Properties
}

struct Properties: Decodable {
    let files: [File]
    let category: String
    let creators: [Creator]
}

struct Creator: Decodable {
    let address: String
    let verified: Bool
    let share: Int
}

struct File: Decodable {
    let uri: String
    let type: String
}

struct OnChain: Decodable {
    let status: String
    let mintHash: String
    let txId: String
    let owner: String
    let chain: String
}
