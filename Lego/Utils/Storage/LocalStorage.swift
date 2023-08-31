//
//  LocalStorage.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 30/08/2023.
//

import Foundation

struct LocalStorage {

    enum Key: String {
        case user
        case authState
    }

//    static func save(key: Key, value: User) {
//        UserDefaults.standard.set(value, forKey: key.rawValue)
//    }
//
//    static func get(key: Key) -> User {
//        return UserDefaults.standard.object(forKey: key.rawValue) as! User
//    }

    static func save<T: Codable>(key: Key, value: T) {
        let data = try? JSONEncoder().encode(value)
        return UserDefaults.standard.set(data, forKey: key.rawValue)
    }

    static func get<T: Codable>(key: Key) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key.rawValue) else { return nil }
        let value  = try? JSONDecoder().decode(T.self, from: data)
        return value
    }

    static func clearAllData() {
        guard let bundleId = Bundle.main.bundleIdentifier else { return }
        UserDefaults.standard.removePersistentDomain(forName: bundleId)
    }
}
