//
//  MainView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/04/2023.
//

import SwiftUI

struct MainView: View {
    @AppStorage("activeMenu") var activeMenu: NavBarMenu = .home
    @State var isHidden = false

    var body: some View {
        ZStack {
            TabView(selection: $activeMenu) {
//                HomeView()
//                    .tag(NavBarMenu.home)
                NFTDetailsView(nft: NFT.fakeData[0])
                    .tag(NavBarMenu.home)

                ProfileView()
                    .tag(NavBarMenu.profile)
            }
            NavigationBar(activeMenu: $activeMenu)
                //.offset(y: appState.isNavBarHidden ? 150 : 0)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
