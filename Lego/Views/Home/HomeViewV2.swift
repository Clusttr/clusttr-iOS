//
//  HomeViewV2.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 11/09/2023.
//

import SwiftUI

struct HomeViewV2: View {
    @State var activeCategory = PropertyCategory.recent
    @StateObject var viewModel = HomeViewModelV2()

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {
                    HStack {
                        Button {

                        } label: {
                            Image.ellipseMenu
                                .resizable()
                                .frame(width: 24, height: 24)
                                .frame(width: 60, height: 60)
                                .background(Color._grey800)
                                .clipShape(Circle())
                        }

                        Spacer()

                        Button {

                        } label: {
                            Image.search
                                .resizable()
                                .frame(width: 24, height: 24)
                                .frame(width: 60, height: 60)
                                .background(Color._grey800)
                                .clipShape(Circle())
                        }

                    }
                    .padding(.horizontal, 30)

                    VStack(alignment: .leading) {
                        Text("Find The Perfect Home")
                            .font(.robotoBold(size: 36))
                            .fontWeight(.black)
                        Text("Discover the best home for you")
                            .fontWeight(.bold)
                            .opacity(0.5)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30)

                    TokenCategoryPicker(activeCategory: $activeCategory)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(viewModel.nfts) { token in
                                NavigationLink(value: token) {
                                    TokenCard(token: token)
                                }
                            }
                        }
                        .padding(.leading, 30)
                    }

                    Spacer()

                }
                .padding(.bottom, 100)
            }
            .foregroundColor(Color._grey100)
            .background(Color._background)
            .navigationDestination(for: NFT.self) { nft in
                NFTDetailsView(nft: nft)
            }
        }
        .task {
            await viewModel.fetchBookmarkedAssets()
            await viewModel.fetchRecentToken()
        }
    }
}

struct HomeViewV2_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewV2(viewModel: HomeViewModelV2(assetService: AssetServiceDouble()))
    }
}
