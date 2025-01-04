//
//  OTPBoxView.swift
//  algorithm classes
//
//  Created by Matthew Chukwuemeka on 04/01/2025.
//

import SwiftUI

struct OTPBoxView: View {
    var value: Character?
    @State var isHidden = false
    @State var timer: Timer?

    var displayValue: String {
        isHidden ? "•" : String(value ?? Character(" "))
    }

    var body: some View {
        Text(displayValue)
            .foregroundColor(Color._grey100)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .frame(width: 45, height: 45)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color._grey700, lineWidth: 1)
            }
            .onAppear {
                startTimer()
            }
            .onDisappear {
                timer?.invalidate()
            }
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { _ in
            //self.isHidden = true
        })
    }
}

#Preview {
    OTPBoxView(value: "1")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color._background)
}
