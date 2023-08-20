//
//  Project.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 31/07/2023.
//

import Foundation
import Fakery

struct Project {
    var title: String
    var description: String
    var developer: String
    var location: String
    var budget: Double
    var assetsValuation: Double
    var averageSharePrice: Double
    var numbersOfInvestors: Int
    var amountInvested: Double
}

extension Project: Hashable {
    
}

extension Project {
    static var data: [Project] {
        let faker = Faker()
        return [
            Project(title: faker.lorem.words(amount: 4),
                    description: faker.lorem.words(amount: 250),
                    developer: "TrustBloc",
                    location: faker.address.secondaryAddress(),
                    budget: 10_000_000,
                    assetsValuation: 12_000_000,
                    averageSharePrice: 40,
                    numbersOfInvestors: 3_469,
                    amountInvested: 6_234_400)
        ]
    }
}
