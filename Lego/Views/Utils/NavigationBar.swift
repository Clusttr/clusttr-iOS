//
//  NavigationBar.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/04/2023.
//

import SwiftUI

struct NavigationBar: View {
    @Binding var activeMenu: NavBarMenu
    @State var circleOffset: Double = .zero
    var menuList = NavBarMenu.allCases

    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 0) {
                GeometryReader { proxy in
                    let buttonWidth = proxy.size.width / Double(menuList.count)
                    HStack(spacing: 0) {
                        ForEach(Array(menuList.enumerated()), id: \.offset) { index, menu in
                            icon(menu)
                                .frame(width: 37, height: 37)
                                .frame(maxWidth: .infinity)
                                .onTapGesture {
                                    activeMenu = menu
                                    withAnimation(.easeInOut) {
                                        circleOffset = Double(activeMenu.index) * buttonWidth
                                        print("circleOffset: ", circleOffset)
                                    }
                                }
                        }
                    }
                    .background {
                        Circle()
                            .fill(Color.accentColor)
                            .frame(width: 65, height: 65)
                            .offset(x: 2.5)
                            .offset(x: circleOffset + 52) // the value 52 is dependant on the width of the button size
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.top, 11)
            }
            .padding(EdgeInsets(top: 11, leading: 28, bottom: 36, trailing: 11))
            .frame(height: 100)
            .background(Color._background)
            .cornerRadius(100)

        }
        .ignoresSafeArea()
    }

    @ViewBuilder
    func icon(_ icon: NavBarMenu) -> some View {
        switch icon {
        case .home:
            Image.home
//        case .search:
//            Image.home
//        case .plus:
//            Image.home
//        case .discovery:
//            Image.home
        case .profile:
            Image.profile
        }
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(activeMenu: .constant(.home))
    }
}
