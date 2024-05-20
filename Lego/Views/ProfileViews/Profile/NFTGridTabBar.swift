//
//  NFTGridTabBar.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/05/2024.
//

import SwiftUI

struct NFTGridTabBar: View {
    @State var activeTab: Options = .house
    var onTabChange: (Options) -> Void

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()
                HStack(alignment: .bottom) {
                    ForEach(Options.allCases) { item in
                        Button {
                            withAnimation {
                                activeTab = item
                            }
                        } label: {
                            Image(systemName: item.image)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .foregroundColor(item == activeTab ? ._grey100 : ._grey400)
                    }
                }
                .frame(maxHeight: .infinity)
                Divider()
                    .frame(height: 2)
                    .background(Color._grey100)
                    .frame(width: geometry.size.width / 4)
                    .offset(x: -(geometry.size.width / 3))
                    .offset(x: (geometry.size.width / 3) * activeTab.index)
                Divider()
            }
            .onChange(of: activeTab) { _, newValue in
                onTabChange(newValue)
            }
        }
        .frame(height: 45)

    }

    enum Options: String, Identifiable, CaseIterable {
        case house
        case bookmark
        case collectable

        var id: String {
            self.rawValue
        }

        var image: String {
            switch self {
            case .house:
                "house.lodge"
            case .bookmark:
                "bookmark"
            case .collectable:
                "tray.full"
            }
        }

        var index: CGFloat {
            switch self {
            case .house:
                0
            case .bookmark:
                1
            case .collectable:
                2
            }
        }
    }
}

#Preview {
    NFTGridTabBar() {_ in}
        .background(Color._grey800)
}
