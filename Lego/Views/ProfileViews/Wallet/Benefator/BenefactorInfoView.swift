//
//  BenefactorInfoView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 23/09/2024.
//

import SwiftUI

struct BenefactorInfoView: View {
    var user: User
    @State private var rotationAngle: Double = 0
    @State private var hearthBeat = false
    @State private var isRotating = true
    
    var body: some View {
        VStack {
            Image.ape
                .resizable()
                .frame(width: 300, height: 300)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(gradient, lineWidth:  6)
                        .blur(radius: 16)
                        .scaleEffect(hearthBeat ? 1.1 : 0.9)
                        .animation(
                            isRotating ? Animation.linear(duration: 1.0)
                                .repeatForever(autoreverses: true) : .default,
                            value: rotationAngle
                        )
                        .rotationEffect(.degrees(rotationAngle))
                        .animation(
                            isRotating ? Animation.linear(duration: 2.0)
                                .repeatForever(autoreverses: false) : .default,
                            value: rotationAngle
                        )
                        .onAppear {
                            rotationAngle = 360
                            hearthBeat = true
                        }
                }

            Text("@\(user.name)")
                .font(.headline)
                .foregroundColor(._grey100)
                .padding(.top, 24)

            AddressView(user.pubkey)
        }
    }

    let gradient = AngularGradient(
        colors: [._accent, .white, ._accent.opacity(0.6)],
        center: .center,
        startAngle: .degrees(270),
        endAngle: .degrees(0)
    )
}

#Preview {
    BenefactorInfoView(user: User.demo())
        .background(Color._background)
}
