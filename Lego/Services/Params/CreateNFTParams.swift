//
//  CreteNFTParams.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 19/08/2023.
//

import Foundation

struct CreateNFTParams: Codable {
    let recipient: String
    let metadata: CreateNFTMetadata
    let reuploadLinkedFiles: Bool
}

struct CreateNFTMetadata: Codable {
    let name: String
    let image: String
    let description: String
}
