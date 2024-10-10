//
//  NFTDetailsView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 18/04/2023.
//

import Charts
import SwiftUI
import SceneKit
import QuickLook

struct NFTDetailsView: View {
    var nft: NFT
    let assetModelCount: Int
    @State var showBuySheet: Bool = false
    @StateObject var viewModel = NFTDetailsViewModel()
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var accountManager: AccountManager

    @State var url: URL?
    @State var isLoading = false
    @State var showSuccess = false
    @State var error: ClusttrError?

    init(nft: NFT) {
        self.nft = nft
        assetModelCount = nft.assetModels.count
    }

    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    ModelSceneView()//assetModels: nft.assetModels.filter{ $0.type == .usdz})

                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 2) {
                            Group {
                                Text(nft.name)
                                    .font(.largeTitle)
                            }
                            .frame(width: UIScreen.screenWidth * 2/3, alignment: .leading)

                            Link(destination: nft.mintHash.assetURL, label: {
                                Text(" #\(nft.mintHash.short(numOfSymbolsRevealed: 4)) view on solscan")
                                    .font(.caption2)
                                    .fontWeight(.medium)
                            })

                            Text(nft.location)
                                .font(.caption)
                                .fontWeight(.semibold)
                        }

                        Text(nft.description)
                            .font(.callout)
                    }
                    .padding(.horizontal, 24)
                    .frame(maxWidth: .infinity, alignment: .leading)

                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text("Features")
                                .font(.headline)
                                .padding(.bottom, 2)

                            Spacer()

                            NavigationLink {
                                PropertyFeatureFullList()
                            } label: {
                                HStack(spacing: 4) {
                                    Text("Show More")
                                    Image(systemName: "chevron.right")
                                }
                                .padding([.leading, .top, .bottom], 4)
                                .clipShape(Rectangle())
                                .font(.footnote)
                                .fontWeight(.bold)
                            }
                        }

                        feature(icon: "square.split.bottomrightquarter", name: "Areas", value: "\(nft.area ?? 0)ft")
                        feature(icon: "bed.double", name: "Bedrooms", value: "\(nft.bedroom ?? 0)")
                        feature(icon: "shower", name: "Baths", value: "\(nft.bathrooms ?? 0)")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)

                    PriceHistoryComponent(transactions: nft.transactions, valuations: nft.valuations)

                    similarProperties

                    Spacer()
                }
                .padding(.bottom, 60)
            }

            VStack {
                Spacer()
                Button {
                    showBuySheet = true
                } label: {
                    Text("Buy Shares")
                        .fontWeight(.bold)
                        .foregroundColor(Color.white.opacity(0.75))
                        .frame(height: 45)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 30)
                        .background(Color.blue)
                }
                .frame(maxWidth: .infinity)
            }

        }
        .overlay {
            HStack(alignment: .bottom) {
                DismissButton()
                Spacer()
                RoundButton(systemName: "cube.transparent") {
                    url = Bundle.main.url(forResource: "Kitchen", withExtension: "usdz")
                }
                    .padding(.trailing)
                    .quickLookPreview($url)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.top)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        .onAppear {
            withAnimation(.easeInOut) {
                appState.isNavBarHidden = true
            }
        }
        .sheet(isPresented: $showBuySheet) {
            PurchaseNFTView(pricePerShare: nft.floorPrice / nft.totalVolume, availableShare: Int(nft.totalVolume), onPurchase: purchase)
                .presentationDetents([.height(420)])
        }
        .loading(isLoading, loaderType: .regular)
        .success($showSuccess)
        .error($error)
    }

    var similarProperties: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Similar Properties")
                .font(.headline)
                .padding(.leading, 24)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.similarProperties) { nft in
                        NavigationLink {
                            NFTDetailsView(nft: nft)
                        } label: {
                            TinyNFTCards(nft: nft)
                        }
                    }
                }
                .padding(.horizontal, 24)
            }
            .padding(.vertical, 8)
        }
    }

    @ViewBuilder
    func feature(icon: String, name: String, value: String) -> some View {
        HStack {
            Image(systemName: icon)
                .opacity(0.9)
            Text(name)
                .opacity(0.9)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
        }
        .font(.footnote)
    }

    func purchase(units: Int) {
        withAnimation(.linear) {
            isLoading = true
            showBuySheet = false
        }

        Task {
            do {
                let tx = try await nft.generateBuyInstruction(units: units, accountManager: accountManager)
                let txString = try await accountManager.sendTransaction(transaction: tx)
                showSuccess = true
                print(txString)
                isLoading = false
                showSuccess = true
            } catch {
                isLoading = false
                self.error = ClusttrError.failedTransaction
            }
        }
    }
}

struct NFTDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NFTDetailsView(nft: NFT.fakeData[0])
            .environmentObject(AppState())
            .environmentObject(AccountManager.create())
    }
}
