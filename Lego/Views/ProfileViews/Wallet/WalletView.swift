//
//  WalletView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/07/2023.
//

import SwiftUI
import Solana

struct WalletView: View {
    var isActive: Bool
    var onClickMenu: () -> Void
    @StateObject var viewModel = WalletViewModel()

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

                AddressView(publicKey: viewModel.publicKey)
            }

            HStack(spacing: 30) {
                Spacer()
                tractionButton(systemName: "square.and.arrow.down", title: "Top up")
                tractionButton(systemName: "square.and.arrow.up", title: "Withdraw")
                tractionButton(systemName: "rectangle.portrait.and.arrow.right", title: "Send")
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
        .task {
            await viewModel.getSolanaBalance()
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

class WalletViewModel: ObservableObject {

    @Published var publicKey: PublicKey?

    init() {
        setupAccount()
    }

    func setupAccount() {
        guard let secretKey = KeyChain.get(key: .SECRET_KEY) else {
            print("no secret key")
            return
        }

        guard let account = HotAccount(secretKey: Data(hex: secretKey)) else { return }

        publicKey = account.publicKey

    }

    func getSolanaBalance() async {
        guard let publicKey = publicKey else { return }

        // get sol Balance
        let endpoint = RPCEndpoint.devnetSolana
        let router = NetworkingRouter(endpoint: endpoint)
        let solana = Solana(router: router)

        do {
            let info: BufferInfo<AccountInfo> = try await solana.api.getAccountInfo(account: publicKey.base58EncodedString, decodedTo: AccountInfo.self)
            print(info)
            print(info.lamports)
            print(info.lamports.convertToBalance(decimals: 9))
        } catch {
            print(error.localizedDescription)
        }

    }

}
