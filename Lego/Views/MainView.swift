//
//  MainView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/04/2023.
//

import SwiftUI

struct MainView: View {
    @State var isHidden = false
    @AppStorage("activeMenu") var activeMenu: NavBarMenu = .home
    @EnvironmentObject var appState: AppState
//    @StateObject var viewModel = MainViewModel()

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
        .onAppear {
            let pin = KeyChain.get(key: .PIN)
            print(pin)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(AppState())
    }
}

//class MainViewModel: ObservableObject {
//    init() {
////        let xchain = KeyChain.load(key: "PIN")
////        if let receivedData = KeyChain.load(key: "PIN") {
////            let result = String(decoding:receivedData, as: UTF32.self)//receivedData.to(type: String.self)
////            print("result: ", result)
////        } else {
////            print("wahala")
////        }
//    }
//}
