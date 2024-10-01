//
//  ResetPinView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 01/10/2024.
//

import AlertToast
import SwiftUI

struct EnterNewPinView: View {
    enum Step {
        case newPassword
        case confirmNewPassword(String)
    }

    var pin: String
    var action: () -> Void
    var userService: IUserService = UserService.create()
    @State private var newPin: String = ""
    @State private var step: Step = .newPassword
    @State private var isLoading: Bool = false
    @State private var error: ClusttrError?
    @State private var showWarning: Bool = false
    private let pinSize = 4

    var buttonTitle: String {
        switch step {
        case .newPassword:
            return "Next"
        case .confirmNewPassword:
            return "Reset Pin"
        }
    }

    var subtitleText: String {
        switch step {
        case .newPassword:
            "Enter your new pin"
        case .confirmNewPassword(_):
            "Enter your new pin again"
        }
    }

    var isButtonDisabled: Bool {
        newPin.count < pinSize
    }

    var body: some View {
        VStack {
            VStack {
                Header(title: "Reset Pin", leadingView: {
                    EmptyView()
                }, trailingView:  {
                    EmptyView()
                })

                Text(subtitleText)
                    .font(.footnote)
                    .foregroundColor(._grey100)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                Spacer()

                OTPView($newPin, size: pinSize)

                Spacer()

                ActionButton(title: buttonTitle, disabled: isButtonDisabled)
                    .padding(.horizontal)
            }
        }
        .background(Color._background)
        .toast(isPresenting: $showWarning) {
            AlertToast(
                displayMode: .banner(.pop),
                type: .complete(Color.green),
                title: "Pin must be equal")
        }
        .error($error)
        .loading(isLoading)
    }

    @MainActor
    func next() {
        switch step {
        case .newPassword:
            step = .confirmNewPassword(newPin)
        case .confirmNewPassword(let oldPin):
            guard oldPin == newPin else {
                return
            }
            Task {
                isLoading = true
                do {
                    _ = try await userService.resetPin(pin: pin, newPin: newPin)
                    isLoading = false
                } catch {
                    self.error = ClusttrError.networkError
                    isLoading = false
                }
            }
        }
    }
}

#Preview {
    EnterNewPinView(pin: "") { }
}
