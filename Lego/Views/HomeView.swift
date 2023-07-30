//
//  HomeView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/04/2023.
//

import SwiftUI

struct HomeView: View {
    @State var NFTs: [NFT] = NFT.fakeData
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("Interesting Projects")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    ProjectCarousel()

                    Text("Trending")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    NFTGrid(NFTs: NFTs)
                        .padding(.horizontal)


                    Text("Popular Developers")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    PopularDeveloperRow()

                    Spacer()
                }
                .padding(.bottom, 100)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
