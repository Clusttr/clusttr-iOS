//
//  DeveloperProfileView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 08/05/2023.
//

import SwiftUI
import Fakery

struct DeveloperProfileView: View {
    @State var nfts = NFT.fakeData
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    @State var showItems = true
    var description: String

    init() {
        description = Faker().lorem.sentences(amount: 12)
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ZStack {
                    VStack {
                        wallpaperAndImage
                        HStack(spacing: 16) {
                            Spacer()
                            Image(systemName: "bell")
                                .font(.footnote)
                                .padding(8)
                                .overlay {
                                    Circle()
                                        .strokeBorder(Color.gray.opacity(0.8), lineWidth: 0.75)
                                }

                            Image(systemName: "envelope")
                                .font(.footnote)
                                .padding(8)
                                .overlay {
                                    Circle()
                                        .strokeBorder(Color.gray.opacity(0.8), lineWidth: 0.75)
                                }
                        }
                        .opacity(0.8)
                        .padding(.trailing)
                    }
                    DismissButton()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding(.top)
                }
                VStack(alignment: .leading) {
                    bio

                    VStack(spacing: 2) {
                        HStack(spacing: 24) {
                            Spacer()
                            Button {
                                showItems = true
                            } label: {
                                Text("Items")
                            }
                            .opacity(showItems ? 1 : 0.6)

                            Button {
                                showItems = false
                            } label: {
                                Text("Activity")
                            }
                            .opacity(showItems ? 0.6 : 1)
                            Spacer()
                        }
                        .fontWeight(.bold)
                        Divider()
                    }
                    .padding(.top)

                    switch showItems {
                    case true:
                        itemsSection
                    case false:
                        VStack {
                            PriceHistoryComponent(transactions: Transaction.data, valuations: Valuation.data)
                            TransactionList()
                        }
                        .padding(.top)
                    }

                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 8)
                .padding(.horizontal, 8)
                Spacer()
            }
            .padding(.bottom, 45)
        }
        .ignoresSafeArea()
        .foregroundColor(.white)
        .background(Color._background)
        .navigationBarBackButtonHidden()
        .onAppear {
            withAnimation(.easeInOut) {
                appState.isNavBarHidden = true
            }
        }
    }

    var itemsSection: some View {
        VStack {
            //MARK: Projects
            VStack(alignment: .leading) {
                Text("Projects")
                    .font(.headline)
                    .padding(.leading, 8)
                ProjectCarousel()
            }
            .padding(.top, 20)

            //MARK: Assets
            VStack(alignment: .leading) {
                Text("Assets")
                    .font(.headline)
                    .padding(.leading, 8)
                NFTGrid(NFTs: nfts)
            }
            .padding(.top, 20)
        }
    }

    var bio: some View {
        VStack(alignment: .leading) {
            Text("TrustBloc Real Estate")
                .font(.title2)
            .fontWeight(.semibold)
            HStack(spacing: 12) {
                Link(destination: Foundation.URL(string: "www.google.com")!) {
                    HStack(spacing: 2) {
                        Image(systemName: "mappin.and.ellipse")
                        Text("Abuja, Nigeria")
                    }
                }

                Link(destination: Foundation.URL(string: "www.google.com")!) {
                    HStack(spacing: 2) {
                        Image(systemName: "link")
                        Text("trustbloc.inc")
                    }
                }

//                Link(destination: Foundation.URL(string: "www.google.com")!) {
//                    HStack(spacing: 2) {
//                        Image(systemName: "wallet.pass")
//                        Text("0x54b2...8794")
//                    }
//                }
            }
            .font(.footnote)

            Text(description)
                .font(.footnote)
                .padding(.top, 4)
        }
        .padding(.horizontal, 8)
    }

    var wallpaperAndImage: some View {
        Image.wallpaper
            .resizable()
            .frame(maxHeight: 220)
            .overlay {
                profilePicture
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    .offset(x: 20, y: 20)

            }
    }

    var profilePicture: some View {
        Image.ape
            .resizable()
            .frame(width: 100, height: 100)
            .cornerRadius(16)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(Color.black, lineWidth: 2)
            }
    }
}

struct DeveloperProfileView_Previews: PreviewProvider {
    static var previews: some View {
        DeveloperProfileView()
            .environmentObject(AppState())
    }
}


struct ContentXView: View {
    let user: User
    var body: some View {
        Text(user.name)
    }
}

struct User: CustomStringConvertible {
    var description: String

    var name: String
}
