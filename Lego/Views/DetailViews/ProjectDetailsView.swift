//
//  ProjectDetailsView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 10/05/2023.
//

import SwiftUI

struct ProjectDetailsView: View {
    var project: Project
    var nfts = NFT.fakeData
    @EnvironmentObject var appState: AppState
    @State private var scrollOffset: CGPoint = .zero
    
    var smallDescription: String {
        String(project.description.prefix(300))
    }

    var heightMultiplier: CGFloat {
        let value = 1 - (scrollOffset.y / 150)
        if value < 0 {
            return 0
        }
        return value
    }

    func wallpaperHeight(height: CGFloat) -> CGFloat {
        return height * heightMultiplier
    }

    var opacity: CGFloat {
        return (1 * heightMultiplier)
    }

    var navBarHeight: CGFloat {
        let height = 100.0
        if heightMultiplier > 0.3 {
            return 0
        }
        return height * (1 - heightMultiplier)
    }

    var navBarOpacity: CGFloat {
        1 * (1 - heightMultiplier)
    }

    var body: some View {
        ZStack {
            Image.wallpaper
                .resizable()
                .frame(maxWidth: .infinity)
                .frame(height: wallpaperHeight(height: 340))
                .frame(maxHeight: .infinity, alignment: .top)
                .opacity(opacity)

            LinearGradient(colors: [Color.clear, Color.black], startPoint: .top, endPoint: .bottom)
                .frame(height: wallpaperHeight(height: 350))
                .frame(maxHeight: .infinity, alignment: .top)
                .opacity(opacity)

            OffsetObservingScrollView(showsIndicators: false, offset: $scrollOffset) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text(project.title)
                                .font(.title)
                                .lineLimit(2)
                                .foregroundColor(.white)
                                .frame(width: UIScreen.screenWidth * 0.6, alignment: .leading)
                            Link(destination: Foundation.URL(string: "www.google.com")!) {
                                HStack(spacing: 2) {
                                    Image(systemName: "mappin.and.ellipse")
                                    Text("Abuja, Nigeria")
                                        .font(.footnote)
                                        .shadow(color: .white.opacity(0.4), radius: 1, x: 1, y: 1)
                                }
                            }
                        }

                        Spacer()

                        VStack(alignment: .trailing) {
                            Image.ape
                                .resizable()
                                .frame(width: 40, height: 40)
                                .cornerRadius(12)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 12)
                                        .strokeBorder(Color.white.opacity(0.5), lineWidth: 1)
                                }
                            Text(project.developer)
                                .font(.footnote)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 24)

                    Text(smallDescription)
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .font(.footnote)

                    VStack(spacing: 8) {
                        HStack {
                            VStack {
                                Text("Budget")
                                Text("$10m")//project.budget, format: .currency(code: "USD"))
                            }

                            VStack {
                                Text("Amount Invested")
                                Text("$6.45m")//project.amountInvested, format: .currency(code: "USD"))
                            }
                        }
                        VStack {
                            Text("Avg. share price")
                                .font(.headline)
                            Text(project.averageSharePrice, format: .currency(code: "USD"))
                                .font(.title)
                                .fontWeight(.bold)
                        }

                        VStack {
                            HStack(spacing: 4) {
                                Image(systemName: "person.3.fill")
                                Text("Investors")
                            }
                            .fontWeight(.semibold)
                            Text(project.numbersOfInvestors, format: .number)
                        }
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)

                    PriceHistoryComponent(transactions: Transaction.data, valuations: Valuation.data)

                    NFTGrid(NFTs: nfts, showBidTime: true)

                }
                .padding(.top, 270)
            }

            HStack(alignment: .bottom) {
                Text(project.title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .padding(.bottom, 22)
                    .frame(width: UIScreen.screenWidth * 0.6)
//                    .background(.white)
            }
            .foregroundColor(Color.white)
            .frame(height: navBarHeight, alignment: .bottom)
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .frame(maxHeight: .infinity, alignment: .top)
            .opacity(navBarOpacity)

            DismissButton()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.top)
        }
        .background(Color._background)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        .onAppear {
            withAnimation(.easeInOut) {
                appState.isNavBarHidden = true
            }
        }
    }
}

struct ProjectDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectDetailsView(project: .data[0])
            .environmentObject(AppState())
    }
}

import Fakery
struct Project {
    var title: String
    var description: String
    var developer: String
    var location: String
    var budget: Double
    var assetsValuation: Double
    var averageSharePrice: Double
    var numbersOfInvestors: Int
    var amountInvested: Double
}

extension Project {
    static var data: [Project] {
        let faker = Faker()
        return [
            Project(title: faker.lorem.words(amount: 4),
                    description: faker.lorem.words(amount: 250),
                    developer: "TrustBloc",
                    location: faker.address.secondaryAddress(),
                    budget: 10_000_000,
                    assetsValuation: 12_000_000,
                    averageSharePrice: 40,
                    numbersOfInvestors: 3_469,
                    amountInvested: 6_234_400)
        ]
    }
}
