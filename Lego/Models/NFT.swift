//
//  NFT.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/04/2023.
//

import Fakery
import Foundation

struct NFT: Identifiable {
    var id: UUID = UUID()
    var name: String
    var creator: String
    var image: String
    var floorPrice: Double
    var totalVolume: Double
    var createdAt: Date
}

extension NFT {
    static var fakeData: [NFT] {
        let faker = Faker()
        return [
            NFT(name: "Ape Club", creator: faker.name.name(), image: "House1", floorPrice: faker.number.randomDouble(min: 10, max: 100), totalVolume: 100, createdAt: faker.date.backward(days: 12)),
            NFT(name: "Ape Club", creator: faker.name.name(), image: "House2", floorPrice: faker.number.randomDouble(min: 10, max: 100), totalVolume: 100, createdAt: faker.date.backward(days: 12)),
            NFT(name: "Ape Club", creator: faker.name.name(), image: "House3", floorPrice: faker.number.randomDouble(min: 10, max: 100), totalVolume: 100, createdAt: faker.date.backward(days: 12)),
            NFT(name: "Ape Club", creator: faker.name.name(), image: "House4", floorPrice: faker.number.randomDouble(min: 10, max: 100), totalVolume: 100, createdAt: faker.date.backward(days: 12)),
            NFT(name: "Ape Club", creator: faker.name.name(), image: "House5", floorPrice: faker.number.randomDouble(min: 10, max: 100), totalVolume: 100, createdAt: faker.date.backward(days: 12)),
            NFT(name: "Ape Club", creator: faker.name.name(), image: "House6", floorPrice: faker.number.randomDouble(min: 10, max: 100), totalVolume: 100, createdAt: faker.date.backward(days: 12))
        ]
    }
}
