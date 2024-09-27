//
//  DeleteConfirmationView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 26/09/2024.
//

import SwiftUI

struct DeleteConfirmationView: View {
    var userService: IUserService
    var bankAccountId: String
    var onDismiss: () -> Void
    var onProceed: (_ bankAccountId: String) -> Void
    @State private var pin = ""
    @State var isLoading: Bool = false
    @State var error: ClusttrError?

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
                OutlineButton(title: "Cancel", action: onDismiss)
                ActionButton(title: "Proceed") {
                    Task {
                        await deleteAccount(id: bankAccountId, pin: pin)
                    }
                }
            }
        }
        .padding()
        .background(Color._background.opacity(0.9))
        .loading(isLoading)
    }

    @MainActor
    func deleteAccount(id bankAccountId: String, pin: String) async {
        isLoading = true
        do {
            let bankAccount = try await userService.deleteBankAccount(
                id: bankAccountId,
                pin: pin
            )
            isLoading = false
            onProceed(bankAccount.id)

        } catch {
            self.error = ClusttrError.networkError
            isLoading = false
        }
    }
}

#Preview {
    DeleteConfirmationView(
        userService: UserService.create(),
        bankAccountId: UUID().uuidString
    ) {

    } onProceed: { bankAccountId in

    }
}
