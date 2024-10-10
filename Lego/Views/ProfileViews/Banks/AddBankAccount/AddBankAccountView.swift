//
//  AddBankAccountView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 27/09/2024.
//

import SwiftUI

struct AddBankAccountView: View {
    var onBankAccountAdded: (BankAccount) -> Void
    @State var accountNumber: String = ""
    @State var currentStep: Step = .pickBank

    enum Step {
        case pickBank
        case enterAccountNumber(bank: Bank)
    }

    var body: some View {
        switch currentStep {
        case .pickBank:
            BankPicker { bank in
                currentStep = .enterAccountNumber(bank: bank)
            }
        case .enterAccountNumber(let bank):
            BankAccountTextFieldView(bank: bank, onAccountAdded: onBankAccountAdded)
        }
    }
}

#Preview {
    AddBankAccountView() { bankAccount in

    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color._background)
}
