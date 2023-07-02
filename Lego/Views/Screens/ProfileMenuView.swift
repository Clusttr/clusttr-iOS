//
//  MenuView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 02/07/2023.
//

import SwiftUI

struct ProfileMenuView: View {
    let menuList: [ProfileMenu] = ProfileMenu.allCases

    var body: some View {
        VStack(spacing: 20) {
            ForEach(menuList) { menu in
                VStack(alignment: .trailing) {
                    HStack {
                        Text(menu.title)
                            .foregroundColor(Color._grey100)

                        menu.icon
                            .foregroundColor(Color._grey100)
                    }
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.trailing, 16)

                    Divider()
                        .background(Color._grey)
                        .opacity(0.35)
                }
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMenuView()
            .background(Color._background)
    }
}

enum ProfileMenu: CaseIterable, Identifiable {
    case profile
    case verifyIdentity
    case banks
    case security
    case referralAndEarn
    case support

    var id: Self { self }

    var title: String {
        switch self {
        case .profile:
            return "Profile"
        case .verifyIdentity:
            return "Verify Identity"
        case .banks:
            return "Banks"
        case .security:
            return "Security"
        case .referralAndEarn:
            return "Referral & Earn"
        case .support:
            return "Support"
        }
    }
}

//icon
extension ProfileMenu {
    var icon: Image {
        switch self {
        case .profile:
            return Image(systemName: "person.fill")
        case .verifyIdentity:
            return Image(systemName: "person.fill.checkmark")
        case .banks:
            return Image(systemName: "building.columns")
        case .security:
            return Image(systemName: "touchid")
        case .referralAndEarn:
            return Image(systemName: "dollarsign.circle")
        case .support:
            return Image(systemName: "person.line.dotted.person")
        }
    }
}
