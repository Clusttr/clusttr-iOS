//
//  VerifyIdentityView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 29/09/2024.
//

import SwiftUI

struct VerifyIdentityView: View {
    var onClickMenu: () -> Void
    var body: some View {
        VStack {
            Header(title: "Verify Identity", leadingView: {
                EmptyView()
            }, trailingView:  {
                Button("", systemImage: "line.3.horizontal", action: onClickMenu)
                    .foregroundColor(._grey100)
                    .fontWeight(.bold)
            })

            LottieView(name: "coming_soon", size: CGSize(width: 25, height: 25), loopMode: .repeat(.infinity))
                .scaleEffect(0.25)
                .frame(width: UIScreen.screenWidth)
        }
        .padding(.top, 50)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color._background)
    }
}

#Preview {
    VerifyIdentityView(){ }
}
