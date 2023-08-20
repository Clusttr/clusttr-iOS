//
//  LottieView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 18/08/2023.
//

import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
    let name: String
    let loopMode: LottieLoopMode

    func makeUIView(context: Context) -> some UIView {
        let animationView = LottieAnimationView(name: name)
        animationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.animationSpeed = 2
        animationView.play()
        return animationView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    
    }
}

struct LottieView_Previews: PreviewProvider {
    static var previews: some View {
        LottieView(name: "construction_progress", loopMode: .loop)
    }
}
