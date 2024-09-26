//
//  DeleteConfirmationView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 26/09/2024.
//

import SwiftUI

struct DeleteConfirmationView: View {
    var bankAccountId: String
    var dismiss: () -> Void
    var proceed: (_ bankAccountId: String, _ pin: String) -> Void
    @State private var pin = ""
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                HStack {
                    Image(systemName: "exclamationmark.triangle")
                    Text("Delete Bank")
                }
                .font(.headline)
                .foregroundColor(._grey100)

                Text("Are you sure you want to proceed with this action?\nPlease enter the 4-digit OTP code provided by your bank.")
                    .font(.footnote)
                    .foregroundColor(._grey2)
            }

            Spacer()

            OTPView($pin, size: 4)

            Spacer()

            HStack(spacing: 16) {
                OutlineButton(title: "Cancel", action: dismiss)
                ActionButton(title: "Proceed") {
                    proceed(bankAccountId, pin)
                }
            }
        }
        .padding()
        .background(Color._background.opacity(0.9))
    }
}

#Preview {
    DeleteConfirmationView(bankAccountId: UUID().uuidString) {

    } proceed: { bankAccountId, pin in

    }

}
