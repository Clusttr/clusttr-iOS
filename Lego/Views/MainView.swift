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
    let accountManager: AccountManager

    init(accountManger: AccountManager = AccountManager(accountFactory: try! AccountFactory(),
                                                        transactionUtility: TransactionUtility(),
                                                        accountUtility: AccountUtility())) 
    {
        self.accountManager = accountManger
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        ZStack {
            TabView(selection: $activeMenu) {
                HomeViewV2()
                    .tag(NavBarMenu.home)

                ProfileScreen()
                    .tag(NavBarMenu.profile)

//                DeveloperView()
//                    .tag(NavBarMenu.developer)
            }
            NavigationBar(activeMenu: $activeMenu)
                .offset(y: appState.isNavBarHidden ? 150 : 10)
        }
        .navigationBarBackButtonHidden(true)
        .environmentObject(accountManager)
        .task {
            print(ClusttrAPIs.getAccessToken())
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(accountManger: AccountManager.mock())
            .environmentObject(AppState())
//            .environmentObject(AccountManager.mock())
    }
}
