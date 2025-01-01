//
//  TokenCard.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 12/09/2023.
//

import SwiftUI

struct TokenCard: View {
//    var token: NFT
    @ObservedObject var vm: TokenCardViewModel

    init(token: NFT, assetService: IAssetService = AssetService()) {
        self.vm = TokenCardViewModel(token: token, assetService: assetService)
    }

    var body: some View {
        AsyncImage(url: URL(string: vm.image)!) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)

        } placeholder: {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.3)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(width: 290, height: 361)
        .clipShape(RoundedRectangle(cornerRadius: 32))
        .overlay {
            VStack(alignment: .trailing) {
                HStack {
                    Text(vm.name)
                        .fontWeight(.bold)
                        .font(.system(size: 33))
                        .multilineTextAlignment(.leading)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, y: 2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Text("$\(vm.price.kmFormatted)")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, y: 2)
                }
                
                Spacer()

                Button {
                    vm.toggleBookmark()
                } label: {
                    Image(systemName: vm.isBookmarked ? "bookmark.fill" : "bookmark")
                        .frame(width: 52, height: 52)
                        .foregroundColor(vm.isBookmarked ? Color._accent : Color._grey100)
                        .background(Color._grey800)
                        .clipShape(Circle())
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .foregroundColor(Color._grey100)
            .padding(.top, 30)
            .padding(.leading, 18)
            .padding(.trailing, 24)
            .padding(.bottom, 24)
        }
    }

}

struct TokenCard_Previews: PreviewProvider {
    static var previews: some View {
        TokenCard(token: NFT.fakeData.first!, assetService: AssetServiceDouble())
    }
}

import Combine
class TokenCardViewModel: ObservableObject {
    @Published var name: String
    @Published var image: String
    @Published var isBookmarked: Bool
    @Published var price: Double

    var assetId: String
    var subscription = Set<AnyCancellable>()
    var assetService: IAssetService

    init(token: NFT, assetService: IAssetService) {
        self.name = token.name
        self.image = token.image
        self.isBookmarked = token.isBookmarked
        self.price = token.floorPrice
        self.assetId = token.id
        self.assetService = assetService

        observeBookmark()
    }

    func observeBookmark() {
        $isBookmarked
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .dropFirst()
//            .map { [self] value in
//                return bookmark(value: value)
//            }
            .sink { [self] value in
                Task {
                    do {
                        let result = try await bookmark(value: value)
                        print(result)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }.store(in: &subscription)
    }

    func toggleBookmark() {
        isBookmarked = !isBookmarked
    }

    func bookmark(value: Bool) async throws -> String {
        switch value {
        case true:
            try await assetService.bookmark(id: assetId)
        case false:
            try await assetService.unbookmark(id: assetId)
        }
    }
}
