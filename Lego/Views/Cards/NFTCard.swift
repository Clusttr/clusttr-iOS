//
//  NFTCard.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/04/2023.
//

import SwiftUI

struct NFTCard: View {
    var vm: NFTCardViewModel

    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: vm.image)!) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)

            } placeholder: {
                Image(systemName: "photo")
            }
            .frame(width: 150, height: 200)


            VStack(alignment: .leading) {
                Spacer()

                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 4) {
                        Text(vm.name)
                    }

                    HStack {
                        VStack(alignment: .leading) {
                            Text("PRICE")
                                .font(.robotoMedium(size: 8))
                                .foregroundColor(._grey)

                            Text(vm.price, format: .number)
                        }

                        Spacer()

                        VStack(alignment: .leading) {
                            Text("TOTAL VOLUME")
                                .font(.robotoMedium(size: 8))
                                .foregroundColor(._grey)

                            Text(vm.amount, format: .currency(code: "USD"))
                        }
                    }
                }
                .font(.robotoMedium(size: 12))
                .foregroundColor(.black)
                .padding(6)
                .background(.white.opacity(0.9))
                .cornerRadius(10)
                .padding(.horizontal, 3)
                .padding(.bottom, 14)
            }
        }
        .frame(width: 150, height: 200)
        .cornerRadius(20)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(.white.opacity(0.25), lineWidth: 1)
        }
    }
}

struct NFTCard_Previews: PreviewProvider {
    static var previews: some View {
        NFTCard(vm: NFTCardViewModel(assetId: ""))
    }
}

import Solana
class NFTCardViewModel: ObservableObject {
    let assetId: String
    @Published var name: String = ""
    @Published var image: String = Image.placeholder
    @Published var price: Double = 0.0
    @Published var amount: Int = 0

    let assetService: IAssetService

    init(assetId: String, assetService: IAssetService = AssetService()) {
        self.assetId = assetId
        self.assetService = assetService
    }

    init(asset: AssetDTO, assetService: IAssetService = AssetService()) {
        self.assetId = asset.id
        self.name = asset.name
        self.amount = 1200
        self.assetService = assetService
    }

    func fetchAsset() {
        //let asset = assetService
    }
}

extension Image {
    static let placeholder = "https://sunrisedaycamp.org/wp-content/uploads/2020/10/placeholder.png"
}
