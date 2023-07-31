//
//  MenuItemView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 31/07/2023.
//

import SwiftUI

struct MenuItemView: View {
    var menu: Menu
    var isSelected: Bool
    var onClick: () -> Void

    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Text(menu.title)
                    .foregroundColor(isSelected ? Color._background : Color._grey100)

                menu.icon
                    .foregroundColor(isSelected ? Color._background : Color._grey100)
            }
            .font(.caption)
            .fontWeight(.semibold)
            .padding(.trailing, 16)

            Divider()
                .background(Color._grey)
                .opacity(0.35)
        }
        .contentShape(Rectangle())
        .padding(.top, 20)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color._grey100)
                .opacity(isSelected ? 1 : 0)
        }
        .onTapGesture(perform: onClick)
    }
}

struct MenuItemView_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemView(menu: ProfileMenu.allCases.first!, isSelected: true, onClick: {})
    }
}
