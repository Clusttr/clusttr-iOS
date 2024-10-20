//
//  WithdrawView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 11/10/2024.
//

import AlertToast
import SwiftUI

struct WithdrawView: View {
    enum Step {
        case enterAmount
        case selectBankAccount(Double)
        case enterPin(amount: Double, bankAccount: BankAccount)

        static var defaultValue: Self = .enterAmount

        func next(amount: Double? = nil, bankAccount: BankAccount? = nil) -> Self {
            switch self {
            case .enterAmount:
                return .selectBankAccount(amount!)
            case .selectBankAccount(let amount):
                return .enterPin(amount: amount, bankAccount: bankAccount!)
            case .enterPin:
                return self
            }
        }
    }
    enum FocusedField {
        case amount
    }

    var rampingService = RampingService.create()
    @State private var amount = ""
    @State private var dollarRate: Double?
    @State private var step: Step = .defaultValue
    @State private var presentPinView = false
    @State private var isLoading = false
    @State private var error: ClusttrError?
    @State private var bankAccounts: [BankAccount] = [.mock(), .mock()]
    @State private var showingSuccessToast = false
    @Environment(\.dismiss) var dismiss
    @FocusState private var focusedField: FocusedField?


    var estimatedValue: Double {
        guard let amount = Double(amount), let dollarRate = dollarRate else { return 0.0}
        return amount * dollarRate
    }

    var showButton: Bool {
        switch step {
        case .selectBankAccount:
            false
        case .enterAmount, .enterPin:
            true
        }
    }

    var body: some View {
        VStack {
            Header<Text, Text>(title: "Withdraw")

            switch step {
            case .enterAmount:
                AmountField()
            case .selectBankAccount, .enterPin(_, _):
                VStack(alignment: .leading, spacing: 24) {
                    Text("Select bank account")
                        .font(.subheadline)
                        .padding(.leading, 16)
                        .padding(.top, 8)
                    BankPicker(bankAccounts: bankAccounts)
                }
            }

            VStack {
                ActionButton(title: "Proceed") {
                    step = step.next(amount: Double(amount))
                }
                .opacity(showButton ? 1 : 0)

                HStack(spacing: 4) {
                    Text("Powered by")

                    Link(destination: URL(string: "https://scalex.com")!) {
                        HStack {
                            Text("ScaleX")
                                .fontWeight(.semibold)
                            Image("scalex")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .clipShape(Circle())
                        }
                    }
                }
                .font(.footnote)
            }
            .padding(.horizontal, 16)
        }
        .foregroundColor(._grey100)
        .background(Color._background)
        .loading(isLoading)
        .error($error)
        .sheet(isPresented: $presentPinView, content: {
            EnterPinView { pin in
                guard case let .enterPin(amount, bankAccount) = step else { return }
                presentPinView = false
                withdraw(
                    amount: amount,
                    bankAccount: bankAccount,
                    pin: pin
                )
            }
            .presentationDetents([.height(250)])
        })
        .toast(isPresenting: $showingSuccessToast) {
            AlertToast(displayMode: .banner(.pop), type: .complete(Color.green), title: "You have successfully withdrawn $\(amount)")
        }
        .task {
            await getDollarRate()
        }
    }

    @ViewBuilder
    private func BankPicker(bankAccounts: [BankAccount]) -> some View {
        ScrollView {
            VStack {
                ForEach(bankAccounts) { bankAccount in
                    BankAccountCard(bankAccount: bankAccount)
                    .padding(.horizontal, 8)
                    .onTapGesture {
                        step = step.next(amount: Double(amount), bankAccount: bankAccount)
                        presentPinView = true
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func AmountField() -> some View {
        VStack {
            Spacer()

            VStack(alignment: .center) {
                HStack {
                    TextField(text: $amount) {
                        Text("0")
                            .foregroundStyle(Color.white)
                    }
                    .focused($focusedField, equals: .amount)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(Color._grey100)

                    Text("USD")
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(Color._grey400)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .defaultFocus($focusedField, .amount)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .onAppear{
                    focusedField = .amount
                }
                Text("≈ ₦\(estimatedValue.rounded(2))")
                    .font(.subheadline)
            }

            Spacer()
            Spacer()
        }
    }

    private func getDollarRate() async {
        do {
            self.dollarRate = try await rampingService.getDollarRate()
        } catch let error as URLSession.APIError {
            self.error = ClusttrError.networkError2(error)
        } catch {
            self.error = ClusttrError.networkError
            isLoading = false
        }
    }

    @MainActor
    private func withdraw(amount: Double, bankAccount: BankAccount, pin: String ) {
        isLoading = true
        Task {
            do {
                let _ = try await rampingService.offRamp(
                    amount: amount,
                    bankAccount: bankAccount,
                    pin: pin
                )
                isLoading = false
                showingSuccessToast = true
                try? await Task.sleep(for: .seconds(3))
                dismiss()
            } catch let error as URLSession.APIError {
                self.error = ClusttrError.networkError2(error)
                isLoading = false
            } catch {
                self.error = ClusttrError.networkError
                isLoading = false
            }
        }
    }
}

#Preview {
    WithdrawView()
}
