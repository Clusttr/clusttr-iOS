//
//  ModelSceneView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 20/04/2023.
//

import SwiftUI
import SceneKit

struct ModelSceneView: View {
    var assetModels: [AssetModel]
    @State var activeIndex: Int = 0
    var body: some View {
        if assetModels.isEmpty {
            Rectangle()
                .fill(.orange)
                .frame(height: UIScreen.screenHeight / 2)
        } else {
            SceneView(scene: SCNScene(named: assetModels[activeIndex].url),
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
    }

    @ViewBuilder
    var modelPager: some View {
        let validRange = (0...assetModels.count - 1)

        HStack {
            assetNavigationButton("chevron.left", isActive: validRange.contains(activeIndex - 1) ) {
                withAnimation {
                    activeIndex -= 1
                }
            }

            ForEach(assetModels) { item in
                RoundedRectangle(cornerRadius: 4)
                    .frame(height: 2.5)
                    .opacity(item.id == assetModels[activeIndex].id ? 1 : 0.5)
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

struct ModelSceneView_Previews: PreviewProvider {
    static var previews: some View {
        ModelSceneView(assetModels: AssetModel.fakeData)
    }
}