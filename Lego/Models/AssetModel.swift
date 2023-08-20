//
//  AssetModel.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 18/04/2023.
//

import Foundation
import Fakery

struct AssetModel: Identifiable, Codable {
    let id: UUID
    let title: String
    let url: String
    let type: AssetModelType
}

extension AssetModel {
    static var fakeData: [AssetModel] = {
        let faker = Faker()
        return [
            AssetModel(id: UUID(), title: "House", url: "House.usdz", type: .usdz),
            AssetModel(id: UUID(), title: "Kitchen", url: "Kitchen.usdz", type: .usdz)
        ]
    }()
}
