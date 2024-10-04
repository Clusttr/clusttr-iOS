//
//  EnterNewPinView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 01/10/2024.
//

import SwiftUI

struct ResetPinView: View {
    enum Step {
        case enterPin
        case enterNewPin(String)
    }

    var onSuccess: () -> Void
    @State var step: Step = .enterPin
    private let pinSize = 4

    var body: some View {
        switch step {
        case .enterPin:
            EnterPinView() { pin in
                step = .enterNewPin(pin)
            }
        case .enterNewPin(let pin):
            EnterNewPinView(pin: pin, action: onSuccess)
        }
    }
}

#Preview {
    ResetPinView() { }
}
