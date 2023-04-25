//
//  NFT.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/04/2023.
//

import Fakery
import Foundation

struct NFT: Identifiable {
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

extension NFT {
    static var fakeData: [NFT] {
        return [
            generateData(name: "Club House", image: "House1"),
            generateData(name: "Twitter House", image: "House2"),
            generateData(name: "Kayla's Court", image: "House3"),
            generateData(name: "Faycob's Court", image: "House4"),
            generateData(name: "Kent Trench", image: "House5"),
            generateData(name: "Halo Reed", image: "House6")
        ]
    }

    private static func generateData(name: String, image: String) -> NFT {
        let faker = Faker()
        return NFT(id: faker.number.randomInt(min: 1, max: 25),
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
