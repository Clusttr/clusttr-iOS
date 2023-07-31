//
//  NFT.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/04/2023.
//

import Fakery
import Foundation

struct NFT: Identifiable, Codable {
    var id: Int
    var name: String
    var location: String
    var description: String
    var creator: String
    var image: String
    var floorPrice: Double
    var totalVolume: Double
    var createdAt: Date
    var assetModels: [AssetModel]
    var transactions: [Transaction]
    var valuations: [Valuation]
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
            generateData(id: 0, name: "Club House", image: "House1"),
            generateData(id: 1, name: "Twitter House", image: "House2"),
            generateData(id: 2, name: "Kayla's Court", image: "House3"),
            generateData(id: 3, name: "Faycob's Court", image: "House4"),
            generateData(id: 4, name: "Kent Trench", image: "House5"),
            generateData(id: 5, name: "Halo Reed", image: "House6")
        ]
    }

    private static func generateData(id: Int, name: String, image: String) -> NFT {
        let faker = Faker()
        return NFT(id: id,
                   name: name,
                   location: faker.address.city(),
                   description: faker.lorem.sentences(amount: 6),
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
