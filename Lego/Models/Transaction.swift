//
//  Transaction.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 24/04/2023.
//

import Foundation
import Fakery

typealias Address = String
struct Transaction: Identifiable {
    var id: UUID
    var createdAt: Date
    var amount: Double
    var from: Address
    var to: Address
//    var contract: Address
//    var assetId: Int
}

extension Array where Element == Transaction {

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

extension Transaction {
    static var data: [Transaction] {
        let faker = Faker()
        let address1 = "0x32CbB3b2Fc1d659876e2F3B57c824EE072Ad42aC"
        let address2 = "0x95b36E1655775B733B2026B482725c5E40ada620"
        return [
            Transaction(id: UUID(), createdAt: faker.date.backward(days: 1200), amount: 56_000, from: address1, to: address2),
            Transaction(id: UUID(), createdAt: faker.date.backward(days: 800), amount: 71_000, from: address1, to: address2),
            Transaction(id: UUID(), createdAt: faker.date.backward(days: 600), amount: 80_000, from: address1, to: address2),
            Transaction(id: UUID(), createdAt: faker.date.backward(days: 350), amount: 93_000, from: address1, to: address2),
            Transaction(id: UUID(), createdAt: faker.date.backward(days: 100), amount: 102_000, from: address1, to: address2),
        ]
    }
}
