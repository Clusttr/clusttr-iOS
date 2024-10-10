//
//  NewFileView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 29/09/2024.
//

import SwiftUI

struct ComingSoonView: View {
    var body: some View {
        LottieView(name: "coming_soon", size: CGSize(width: 25, height: 25), loopMode: .repeat(.infinity))
            .scaleEffect(0.25)
    }
}

#Preview {
    ComingSoonView()

}
