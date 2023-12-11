//
//  TokenCard.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 12/09/2023.
//

import SwiftUI

struct TokenCard: View {
    var token: NFT

    var body: some View {
        AsyncImage(url: URL(string: token.image)!) { image in
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
                    Text(token.name)
                        .fontWeight(.bold)
                        .font(.system(size: 33))
                        .multilineTextAlignment(.leading)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, y: 2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Text("$\(token.floorPrice.kmFormatted)")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, y: 2)
                }
                
                Spacer()

                Button {

                } label: {
                    Image(systemName: "bookmark")
                        .frame(width: 52, height: 52)
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
        TokenCard(token: NFT.fakeData.first!)
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(_ places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
