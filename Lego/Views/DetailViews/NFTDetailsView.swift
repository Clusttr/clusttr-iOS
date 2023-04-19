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
    @Environment(\.dismiss) var dismiss

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
            Spacer()
        }
        .overlay {
            VStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(12)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.25), radius: 10, x: 5, y: 5)
                        .padding(.top, 32)
                        .padding(.leading, 16)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
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
        .frame(width: UIScreen.screenWidth / 2.5)
    }

    @ViewBuilder
    func assetNavigationButton(_ systemImage: String,
                               isActive: Bool,
                               _ action: @escaping () -> Void) -> some View {

        Button(action: action) {
            Image(systemName: systemImage)
                .scaleEffect(0.75)
                .foregroundColor(.white)
                .padding(6)
                .background {
                    Circle()
                        .fill(.black)
                        .opacity(0.5)
                }
                .overlay {
                    Circle()
                        .strokeBorder(Color.white.opacity(0.75), lineWidth: 1)
                }
                .padding(2)
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
