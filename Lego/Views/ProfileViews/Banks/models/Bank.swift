//
//  Bank.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 27/09/2024.
//

import Fakery
import SwiftUI

struct Bank: Identifiable {
    var id: String
    var name: String
    var logo: String

    var logoURL: URL {
        URL(string: logo)!
    }
}

extension Bank {
    static func mock() -> Self {
        let faker = Faker()
        return .init(
            id: UUID().uuidString,
            name: faker.company.name(),
            logo: faker.company.logo()
        )
    }
}
