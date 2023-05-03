//
//  PurchaseNFTView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 26/04/2023.
//

import SwiftUI

struct PurchaseNFTView: View {
    var transactionFee: Double = 3
    var serviceChargePercentage: Double = 0.025
    var pricePerShare: Double
    var availableShare: Int
    @State var units: String = ""

    var unitsInteger: Int {
        Int(units) ?? 0
    }

    var totalAmountOfUnit: Double {
        Double(unitsInteger) * pricePerShare
    }

    var serviceCharge: Double {
        totalAmountOfUnit * serviceChargePercentage
    }

    var total: Double {
        totalAmountOfUnit + transactionFee + serviceCharge
    }

    var body: some View {
        VStack(spacing: 18) {

            HStack {
                VStack(alignment: .leading) {
                    Text("Price per share")
                        .fontWeight(.semibold)
                    Text("$\(pricePerShare.roundUpString(2))")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                }

                Spacer()

                VStack(alignment: .trailing) {
                    Text("Available shares")
                        .fontWeight(.semibold)
                    Text(String(availableShare))
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                }
            }

            VStack(spacing: 6) {
                Text("Enter number of units you wish to buy")
                    .fontWeight(.semibold)
                TextField("", text: $units)
                    .keyboardType(.numberPad)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .frame(width: 150)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 8)
                    .background(Color.primary.opacity(0.1))
                    .cornerRadius(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(Color.accentColor.opacity(0.5), lineWidth: 0.5)
                    }
                .padding(.bottom, 24)
            }

            VStack {
                HStack {
                    Text("Transaction fee")
                    Spacer()
                    Text("$\(transactionFee)")
                }
                Divider()
                HStack {
                    Text("Service charge (2.5%)")
                    Spacer()
                    Text("$\(serviceCharge)")
                }
                Divider()
                HStack {
                    Text("Shares price (\(pricePerShare.roundUpString(2)) x \(unitsInteger))")
                    Spacer()
                    Text("$\(totalAmountOfUnit.roundUpString(2))")
                }
                Divider()
                HStack {
                    Text("Total")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Spacer()
                    Text("$\(total.roundUpString(2))")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
            }

            Button {

            } label: {
                Text("Buy")
                    .font(.headline)
                    .frame(height: 44)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(16)
                    .padding(.horizontal, 40)
            }
            .padding(.top, 30)

        }
        .font(.footnote)
        .padding(.horizontal)
        .padding(.top, 24)
        .padding(.vertical, 40)
    }
}

struct PurchaseNFTView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseNFTView(pricePerShare: 172, availableShare: 928)
    }
}
