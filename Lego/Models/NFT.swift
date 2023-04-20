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
    var assetModels: [AssetModel]
}

extension NFT {
    static var fakeData: [NFT] {
        let faker = Faker()
        return [
            NFT(name: "Club House", creator: faker.name.name(), image: "House1", floorPrice: faker.number.randomDouble(min: 10, max: 100), totalVolume: 100, createdAt: faker.date.backward(days: 12), assetModels: AssetModel.fakeData),
            NFT(name: "Twitter House", creator: faker.name.name(), image: "House2", floorPrice: faker.number.randomDouble(min: 10, max: 100), totalVolume: 100, createdAt: faker.date.backward(days: 12), assetModels: AssetModel.fakeData),
            NFT(name: "Kayla's Court", creator: faker.name.name(), image: "House3", floorPrice: faker.number.randomDouble(min: 10, max: 100), totalVolume: 100, createdAt: faker.date.backward(days: 12), assetModels: AssetModel.fakeData),
            NFT(name: "Faycob's Court", creator: faker.name.name(), image: "House4", floorPrice: faker.number.randomDouble(min: 10, max: 100), totalVolume: 100, createdAt: faker.date.backward(days: 12), assetModels: AssetModel.fakeData),
            NFT(name: "Kent Trench", creator: faker.name.name(), image: "House5", floorPrice: faker.number.randomDouble(min: 10, max: 100), totalVolume: 100, createdAt: faker.date.backward(days: 12), assetModels: AssetModel.fakeData),
            NFT(name: "Halo Reed", creator: faker.name.name(), image: "House6", floorPrice: faker.number.randomDouble(min: 10, max: 100), totalVolume: 100, createdAt: faker.date.backward(days: 12), assetModels: AssetModel.fakeData)
        ]
    }
}
