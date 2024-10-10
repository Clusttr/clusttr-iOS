//
//  socials.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 29/09/2024.
//

import Foundation

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

    var url: URL {
        switch self {
        case .x:
            return URL(string: "tg://resolve?domain=clusttr")!
        case .discord:
            return URL(string: "https://discord.gg/yourInviteCode")!
        case .telegram:
            return URL(string: "twitter://user?screen_name=clusttr_io")!
        }
    }
}
