//
//  Valuation.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 25/04/2023.
//

import Foundation
import Fakery

struct Valuation: Identifiable, Codable {
    var id: UUID
    var amount: Double
    var createdAt: Date
}

extension Valuation {
    static var data: [Valuation] {
        let faker = Faker()
        return [
            Valuation(id: UUID(), amount: 58_000, createdAt: faker.date.backward(days: 1200)),
            Valuation(id: UUID(), amount: 69_600, createdAt: faker.date.backward(days: 850)),//20%
            Valuation(id: UUID(), amount: 76_560, createdAt: faker.date.backward(days: 500)),//10%
            Valuation(id: UUID(), amount: 86_512.8, createdAt: faker.date.backward(days: 150)),//13%
        ]
    }
}


extension Array where Element == Valuation {

    func yearlyAveragePrice() -> [Int: Double] {
        var yearToAverage: [Int: Double] = [:]
        var yearCount: [Int: Double] = [:]

        for transaction in self {
            let year = Int(transaction.createdAt.year) ?? 0
            yearToAverage[year, default: 0] += transaction.amount
            yearCount[year, default: 0] += 1
        }

        for item in yearToAverage {
            let occurrence = yearCount[item.key, default: 0.0]
            yearToAverage[item.key] = item.value/occurrence
        }

        return yearToAverage
    }
}
