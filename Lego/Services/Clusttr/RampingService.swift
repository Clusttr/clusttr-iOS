//
//  RampingService.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 15/10/2024.
//

import SwiftUI

protocol IRampingService {
    func getDollarRate() async throws -> Double
    func onRamp() async throws -> Double
    func offRamp(amount: Double, bankAccount: BankAccount, pin: String) async throws -> Double
}

extension IRampingService {
    static func create() -> IRampingService {
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            RampingServiceDouble()
        } else {
            RampingService()
        }
    }
}

struct RampingService: IRampingService {
    func getDollarRate() async throws -> Double {
        return 1700
    }
    
    func onRamp() async throws -> Double {
        return 0
    }
    
    func offRamp(amount: Double, bankAccount: BankAccount, pin: String) async throws -> Double {
        return 0
    }
}

struct RampingServiceDouble: IRampingService {
    func getDollarRate() async throws -> Double {
        try? await Task.sleep(for: .seconds(3))
        return 1700
    }
    
    func onRamp() async throws -> Double {
        try? await Task.sleep(for: .seconds(3))
        return 0
    }
    
    func offRamp(amount: Double, bankAccount: BankAccount, pin: String) async throws -> Double {
        try? await Task.sleep(for: .seconds(3))
        return 0
    }
}
