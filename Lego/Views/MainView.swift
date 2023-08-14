//
//  MainView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/04/2023.
//

import SwiftUI
import Solana

struct MainView: View {
    @State var isHidden = false
    @AppStorage("activeMenu") var activeMenu: NavBarMenu = .home
    @EnvironmentObject var appState: AppState
    @StateObject var accountManager = AccountManager(.dev)

    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        ZStack {
            TabView(selection: $activeMenu) {
                HomeView()
                    .tag(NavBarMenu.home)

                ProfileScreen()
                    .tag(NavBarMenu.profile)
            }
            NavigationBar(activeMenu: $activeMenu)
                .offset(y: appState.isNavBarHidden ? 150 : 10)
        }
        .navigationBarBackButtonHidden(true)
        .environmentObject(accountManager)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(AppState())
            .environmentObject(AccountManager(.dev))
    }
}
