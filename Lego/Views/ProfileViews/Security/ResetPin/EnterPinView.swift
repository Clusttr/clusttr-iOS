//
//  EnterPinDialog.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 01/10/2024.
//

import SwiftUI

struct EnterPinView: View {
    var action: (String) -> Void
    @State private var pin: String = ""
    private let pinSize = 4

    var body: some View {
        VStack {
            VStack {
                Header(title: "Enter Pin", leadingView: {
                    EmptyView()
                }, trailingView:  {
                    EmptyView()
                })

                Text("Enter your existing pin")
                    .font(.footnote)
                    .foregroundColor(._grey100)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                Spacer()

                OTPView($pin, size: pinSize)

                Spacer()

                ActionButton(title: "Next", disabled: pin.count < pinSize) {
                    action(pin)
                }
                .padding(.horizontal)
            }
        }
        .background(Color._background)
    }
}

#Preview {
    EnterPinView() {pin in }
}
