//
//  WalletView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/07/2023.
//

import SwiftUI

struct WalletView: View {
    var isActive: Bool
    var onClickMenu: () -> Void

    var body: some View {
        VStack {
            VStack(spacing: 8) {
                HStack(alignment: .bottom, spacing:2) {
                    Text("$120,000")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Image(systemName: "info.circle")
                        .font(.caption)
                        .fontWeight(.medium)
                }
                .foregroundColor(Color._grey100)

                Text("0x12AbxZ....23abXD")
                    .font(.caption)
                    .foregroundColor(._grey100)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 16)
                    .background {
                        LinearGradient(colors: [Color._grey.opacity(0.25),
                                                Color.pink.opacity(0.7),
                                                Color.orange.opacity(0.5),
                                                Color._grey100.opacity(0.25)],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing)
                        .opacity(0.3)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
            }

            HStack(spacing: 30) {
                Spacer()
                tractionButton(systemName: "square.and.arrow.down", title: "Top up")
                tractionButton(systemName: "square.and.arrow.up", title: "Withdraw")
                tractionButton(systemName: "rectangle.portrait.and.arrow.right", title: "Top up")
                Spacer()
            }
            .padding(.top, 45)

            VStack {
                HStack {
                    Text("Benefactors")
                        .font(.footnote)

                    Spacer()
                    Image(systemName: "qrcode.viewfinder")
                        .fontWeight(.bold)
                }
                .foregroundColor(._grey100)
                .padding(.horizontal)

                BenefactorRow()
            }
            .padding(.top, 45)

            Spacer()
        }
        .padding(.top, 90)
        .background(Color._background)
        .overlay {
            VStack(alignment: .trailing) {
                HStack {
                    Spacer()
                    Button(action: onClickMenu) {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(Color._grey100)
                            .fontWeight(.black)
                    }
                    .padding()
                    .opacity(isActive ? 1 : 0)
                }
                Spacer()
            }
            .padding(.top, 44)
        }
    }

    func tractionButton(systemName: String, title: String) -> some View {
        VStack(spacing: 2) {
            Image(systemName: systemName)
                .frame(width: 37, height: 37)
                .background(Color._grey700)
                .clipShape(Circle())
            Text(title)
                .font(.caption2)
                .fontWeight(.semibold)
        }
        .foregroundColor(._grey100)
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView(isActive: true, onClickMenu: {})
            .background(Color._background)
            .ignoresSafeArea()
    }
}
