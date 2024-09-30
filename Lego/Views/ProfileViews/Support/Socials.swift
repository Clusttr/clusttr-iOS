//
//  socials.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 29/09/2024.
//

enum Socials: String, Identifiable, CaseIterable {
    case x, discord, telegram

    var id: String { rawValue }

    var logoName: String {
        switch self {
        case .x: return "x_logo"
        case .discord: return "discord_logo"
        case .telegram: return "telegram_logo"
        }
    }
}
