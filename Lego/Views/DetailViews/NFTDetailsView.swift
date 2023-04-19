//
//  NFTDetailsView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 18/04/2023.
//

import SwiftUI
import SceneKit

struct NFTDetailsView: View {
    var nft: NFT
    let assetModelCount: Int
    @State var activeIndex: Int = 0

    init(nft: NFT) {
        self.nft = nft
        assetModelCount = nft.assetModels.count
    }
    var body: some View {
        VStack {
            if nft.assetModels.isEmpty {
                Rectangle()
                    .fill(.orange)
                    .frame(height: UIScreen.screenHeight / 2)
            } else {
                SceneView(scene: SCNScene(named: nft.assetModels[activeIndex].url),
                          options: [.autoenablesDefaultLighting, .allowsCameraControl])
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.screenHeight / 2)
                .overlay {
                    VStack(alignment: .leading) {
                        Spacer()
                        modelPager
                            .padding(8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            Text("\(nft.assetModels.count)")
            Spacer()
        }
        .ignoresSafeArea()
    }

    @ViewBuilder
    var modelPager: some View {
        let validRange = (0...nft.assetModels.count - 1)

        HStack {
            assetNavigationButton("chevron.left", isActive: validRange.contains(activeIndex - 1) ) {
                withAnimation {
                    activeIndex -= 1
                }
            }

            ForEach(nft.assetModels) { item in
                RoundedRectangle(cornerRadius: 4)
                    .frame(height: 2.5)
                    .opacity(item.id == nft.assetModels[activeIndex].id ? 1 : 0.5)
                    .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 0)
            }

            assetNavigationButton("chevron.right", isActive: validRange.contains(activeIndex + 1)) {
                withAnimation {
                    activeIndex += 1
                }
            }
        }
        .frame(width: UIScreen.screenWidth / 3)
    }

    @ViewBuilder
    func assetNavigationButton(_ systemImage: String,
                               isActive: Bool,
                               _ action: @escaping () -> Void) -> some View {

        Button(action: action) {
            Image(systemName: systemImage)
                .foregroundColor(.black)
                .padding(8)
                .background {
                    Circle()
                        .fill(.black)
                        .opacity(0.3)
                }
        }
        .disabled(!isActive)
        .opacity(isActive ? 1 : 0.3)

    }
}

struct NFTDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NFTDetailsView(nft: NFT.fakeData[0])
    }
}
