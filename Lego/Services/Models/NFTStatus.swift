//
//  NFTStatus.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 19/08/2023.
//

import Foundation

struct NFTStatus: Codable {
    let id: String
    let onChain: OnChain

    struct OnChain: Codable {
        let status: String
        let chain: String
    }
}
