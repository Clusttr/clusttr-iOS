//
//  TransactionItem.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 10/05/2023.
//

import SwiftUI

struct TransactionItem: View {

    @State var isShowingDetails = false
    var body: some View {

        VStack(spacing: 8) {
            HStack(alignment: .top) {
                Image("House1")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .cornerRadius(12)
                    .padding(.top, 6)
                VStack(alignment: .leading, spacing: 4) {
                    Text("TrustBloc")
                        .fontWeight(.semibold)
                        .opacity(0.75)
                    Text("Halo Creek #14")
                        .fontWeight(.bold)
                    Button {
                        withAnimation {
                            isShowingDetails.toggle()
                        }
                    } label: {
                        Text(isShowingDetails ? "- Less" : "+ More")
                            .fontWeight(.semibold)
                            .opacity(0.75)
                    }

                }
                .padding(.leading, 8)

                Spacer()

                VStack(alignment: .trailing, spacing: 4) {
                    Text("Sale")
                        .fontWeight(.semibold)
                        .opacity(0.75)
                    Text("$5,000")
                        .lineLimit(1)
                        .fontWeight(.bold)
                    Text("11 hours ago")
                        .fontWeight(.semibold)
                        .opacity(0.75)
                }
            }
            .padding(.horizontal)
            .background(Color._background)
            .zIndex(1)

            VStack {
                Rectangle()
                    .frame(height: 1)
                    .opacity(isShowingDetails ? 0.5 : 0)
                HStack {
                    VStack {
                        Text("Price per share")
                            .opacity(0.75)
                        Text("$40")
                    }
                    .frame(maxWidth: .infinity)

                    VStack {
                        Text("Quantity")
                            .opacity(0.75)
                        Text("125")
                    }
                    .frame(maxWidth: .infinity)

                    VStack {
                        Text("From")
                            .opacity(0.75)
                        Text("0x43cd...0s4t")
                            .foregroundColor(.blue)
                    }
                    .frame(maxWidth: .infinity)

                    VStack {
                        Text("To")
                            .opacity(0.75)
                        Text("0x62cf...er47")
                            .foregroundColor(.blue)
                    }
                    .frame(maxWidth: .infinity)
                }
                .font(.caption2)
                .padding(.horizontal)
            }
            .frame(height: isShowingDetails ? 40 : 0)
            .background(Color._background)
            .zIndex(0)
            .offset(y: isShowingDetails ? 0 : -50)
        }
        .font(.footnote)
        .padding(.horizontal, 4)
        .padding(.vertical)
        .foregroundColor(.white)
        .background(Color._background)
    }
}

struct TransactionItem_Previews: PreviewProvider {
    static var previews: some View {
        TransactionItem()
    }
}
