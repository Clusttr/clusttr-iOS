//
//  LegoApp.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 13/04/2023.
//

import SwiftUI

@main
struct LegoApp: App {
    @State var appState: AppState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
