//
//  BankPicker.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 27/09/2024.
//

import SwiftUI

struct BankPicker: View {
    var onSelect: (Bank) -> Void
    @State private var addressText: String = ""
    @State private var selectedBank: Bank?
    @State private var banks: [Bank] = [.mock(), .mock(), .mock()]
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Text("Choose Bank")
                        .font(.headline)
                        .foregroundColor(._grey100)
                    Spacer()
                }
                .frame(height: 50)
                Divider()
            }

            searchView
                .padding(.horizontal, 16)
                .padding(.top, 24)

            ScrollView {
                VStack {
                    ForEach(banks) { bank in
                        Button(action: {
                            onSelect(bank)
                        }) {
                            VStack {
                                BankCard(bank: bank)
                                Divider()
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
                .padding(.top, 32)
            }

        }

    }

    var searchView: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white.opacity(0.7))

                TextField("Search", text: $addressText)
                    .placeholder(when: addressText.isEmpty) {
                        Text("Search for a bank")
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .accentColor(.red)
                    .foregroundColor(.white)
            }
            .foregroundColor(Color.white.opacity(0.7))
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .frame(height: 48)
            .background(.white.opacity(0.07))
            .cornerRadius(6)
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.white.opacity(0.3))
            }
        }
    }

}

#Preview {
    BankPicker() { bank in

    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color._background)
}
