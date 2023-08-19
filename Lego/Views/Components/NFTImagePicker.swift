//
//  NFTImagePicker.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 18/08/2023.
//

import SwiftUI

struct NFTImagePicker: View {
    @Binding var imageURL: String

    var body: some View {
        VStack(spacing: 8) {
            if imageURL.isEmpty {
                Image(systemName: "photo")
                Text("Click here to paste image url")
                    .font(.subheadline)
                    .fontWeight(.medium)
            } else {
                AsyncImage(url: URL(string: imageURL)) { image in
                    ZStack {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.red)
                            .blur(radius: 10)
                            .opacity(0.75)
                        image
                            .aspectRatio(contentMode: .fit)
                    }
                } placeholder: {
                    ProgressView()
                }
            }
        }
        .frame(height: 180)
        .frame(maxWidth: .infinity)
        .foregroundColor(Color._grey400)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5]))
                .foregroundColor(._grey400)
        }
        .padding(.horizontal)
        .onTapGesture {
            pastImageURL()
        }
    }

    func pastImageURL() {
        guard let imageURL = UIPasteboard.general.string else {
            return
        }
        self.imageURL = imageURL
    }
}

struct NFTImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        NFTImagePicker(imageURL: .constant(""))
    }
}
