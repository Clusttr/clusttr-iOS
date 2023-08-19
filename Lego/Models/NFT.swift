//
//  NFT.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/04/2023.
//

import Fakery
import Foundation
import Solana

struct NFT: Identifiable, Codable {
    var id: String
    var mintHash: PublicKey
    var owner: PublicKey
    var name: String
    var description: String
    var location: String
    var creator: String
    var image: String
    var floorPrice: Double
    var totalVolume: Double
    var createdAt: Date
    var assetModels: [AssetModel]
    var transactions: [Transaction]
    var valuations: [Valuation]
}

extension NFT {
    init(nft: NFTModel) {
        self.id = nft.id
        self.mintHash = PublicKey(string: nft.onChain.mintHash)!
        self.owner = PublicKey(string: nft.onChain.owner)!
        self.name = nft.metadata.name
        self.description = nft.metadata.description
        self.location = "8th Street Lane"
        self.creator = nft.metadata.properties.creators.first?.address ?? "no creator"
        self.image = nft.metadata.image
        self.floorPrice = 10.6
        self.totalVolume = 72.1
        self.createdAt = Date()
        self.assetModels = AssetModel.fakeData
        self.transactions = Transaction.data
        self.valuations = Valuation.data
    }
}

extension NFT: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension NFT: Equatable {
    static func == (lhs: NFT, rhs: NFT) -> Bool {
        return lhs.id == rhs.id
    }
}

extension NFT {
    static var fakeData: [NFT] {
        return [
            generateData(id: UUID().uuidString, name: "Club House", image: "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSjQTOgrQKGJZPZbpTQSAP18wB-Zoc_XB3J6e4dVHq8OHOMn6gj"),
            generateData(id: UUID().uuidString, name: "Twitter House", image: "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcRZJ8awhuWhiqwRb_H8xEh6SaFcll2D2c-1ye4ZK03fgwzxUz9P"),
            generateData(id: UUID().uuidString, name: "Kayla's Court", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6xk-B2-mOoQUwrPW76NT4n5n_vQbIBenGFKZ08nXxgxtoyLA7"),
            generateData(id: UUID().uuidString, name: "Faycob's Court", image: "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQvRYx7n54UyrJyEMhYUSahdBVyAqb48qQTaYeGXhuuU6W5XkL4"),
            generateData(id: UUID().uuidString, name: "Kent Trench", image: "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTDpAfHsKkATQsKzH-_PFVM_YO841SdodKjFScCDzj8yU9KwZVB"),
            generateData(id: UUID().uuidString, name: "Halo Reed", image: "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcRFIqpupgi5b-lrmy2QInZsDnXcc61DATWWQ_0bL3hfeJ-Oth3n")
        ]
    }

    private static func generateData(id: String, name: String, image: String) -> NFT {
        let faker = Faker()
        return NFT(id: id,
                   mintHash: PublicKey(string: "9oxUFdEKQuALyLM4p8djGSbH19P9ihBiKeyDgFDubtzq")!,
                   owner: PublicKey(string: "DpmMV7knnwZcBeLXv9dX3fCHA8jCw7SA7Lzq4dvj1NR3")!,
                   name: name,
                   description: faker.lorem.sentences(amount: 6), location: faker.address.city(),
                   creator: faker.name.name(),
                   image: image,
                   floorPrice: faker.number.randomDouble(min: 10, max: 100),
                   totalVolume: 100,
                   createdAt: faker.date.backward(days: 12),
                   assetModels: AssetModel.fakeData,
                   transactions: Transaction.data,
                   valuations: Valuation.data)
    }
}
