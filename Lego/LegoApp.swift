//
//  LegoApp.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 13/04/2023.
//

import SwiftUI
import UserNotifications

@main
struct LegoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @State var appState: AppState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .environmentObject(appDelegate)
                .task {
                    do {
                        let message = try await AuthService.test()
                        print(message)
                    } catch {
                        print(error)
                        print(error.localizedDescription)
                    }
                }
        }
    }
    


}

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        setupNotification(application)
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //TODO: register push notification
        let tokens = deviceToken.reduce("") { $0 + String(format: "%02x", $1)}
        print("Device token: \(tokens)")
    }

    func setupNotification(_ application: UIApplication) {
        Task {
            let centre = UNUserNotificationCenter.current()
            let result = try await centre.requestAuthorization(options: [.alert, .badge, .sound])
            print("Notification Result \(result)")

            await MainActor.run {
                application.registerForRemoteNotifications()
            }
        }

    }
}
