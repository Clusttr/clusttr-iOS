//
//  AssetDTO.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 14/10/2023.
//

import Foundation

struct AssetDTO: Codable {
    let id: String
    let uri: String
    let attribute: [AttributeDTO]
    let description: String
    let name: String
    let symbol: String
    let image: String
    let supply: Double
    let maxSupply: Double
    let files: [FileDTO]
}

struct AttributeDTO: Codable {
    let value: String
    let traitType: String
}

struct FileDTO: Codable {
    let uri: String
    let mime: String
}

extension AssetDTO {
    static func demo() -> AssetDTO {
        AssetDTO(id: "FznkHFZVncLk79yKpdDdsR1ZWa1EZpuYrBGVRLeTrQRg",
                 uri: "https://lavender-following-rabbit-173.mypinata.cloud/ipfs/QmSrSw8H3DUTVWzcAyZY1pQzcQFh9zxCVsHwn3aWU9exLr",
                 attribute: AttributeDTO.demoList(),
                 description: "LOTUS EX SUITE is a one bedroom unit with a well set out lounge and a visitor's toilet.\nEquipped with a Satellite TV Network, Free super fast internet, 24/7 electricity, fully equipped kitchenette, washing machine and free parking within a gated compound in a safe, serene and homely neighbourhood.\nFree access to swimming pool, gym, and playground located within 10 minutes walking distance from the apartment.",
                 name: "Chatam House 2",
                 symbol: "LEX",
                 image: "https://lavender-following-rabbit-173.mypinata.cloud/ipfs/QmcuqSUErnHMCVAqSR2UDTmN555hEeaVUc5FM76AVutGju",
                 supply: 50,
                 maxSupply: 50,
                 files: FileDTO.demoList())
    }
}

extension AttributeDTO {
    static func demoList() -> [AttributeDTO] {
        [
            AttributeDTO(value: "2", traitType: "bedroom"),
            AttributeDTO(value: "1.5", traitType: "bathrooms"),
            AttributeDTO(value: "2253", traitType: "area"),
            AttributeDTO(value: "Unit 3, Kayla's Court", traitType: "address"),
            AttributeDTO(value: "[6.4564231,3.5144315,0]", traitType: "coordinate")
        ]
    }
}

extension FileDTO {
    static func demoList() -> [FileDTO] {
        [
            FileDTO(uri: "https://lavender-following-rabbit-173.mypinata.cloud/ipfs/QmcuqSUErnHMCVAqSR2UDTmN555hEeaVUc5FM76AVutGju",
                    mime: "image/png"),
            FileDTO(uri: "https://lavender-following-rabbit-173.mypinata.cloud/ipfs/QmU5kVfMwBF5xS889BwRSoDmi1Taahzo4qYhcqcY6dWTmX",
                    mime: "usdz"),
            FileDTO(uri: "https://lavender-following-rabbit-173.mypinata.cloud/ipfs/QmWMRLVJ7yjUPiMwfLs8Q2VvFJ1QtFeG4oT6i8HwZZPYnJ",
                    mime: "usdz")
        ]
    }
}
