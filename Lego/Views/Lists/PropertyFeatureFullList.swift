//
//  PropertyFeatureFullList.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 24/04/2023.
//

import SwiftUI

struct PropertyFeatureFullList: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Facts and features")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.title3)

                VStack(alignment: .leading) {
                    Text("Interior details")
                        .font(.headline)
                        .padding(.bottom, 2)

                    subsection()
                }
            }
        }
    }

    @ViewBuilder
    func feature(icon: String, name: String, value: String) -> some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 8)
                .opacity(0.9)
            Text(name)
                .opacity(0.9)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
        }
        .font(.footnote)
    }

    @ViewBuilder
    func subsection() -> some View {
        VStack(alignment: .leading) {
            Text("Bedrooms and bathrooms")
                .font(.subheadline)
                .fontWeight(.semibold)
            feature(icon: "bed.double", name: "Bedrooms", value: "4")
            feature(icon: "shower", name: "Bathrooms", value: "5")
            feature(icon: "shower.fill", name: "Full Bathrooms", value: "4")
        }
        .padding(.horizontal, 8)
    }
}

struct PropertyFeatureFullList_Previews: PreviewProvider {
    static var previews: some View {
        PropertyFeatureFullList()
    }
}

struct Feature {
    var name: String
    var value: String
    var unit: String?
}

extension Feature {
    var image: String {
        switch name.lowercased() {
        case "bedrooms":
            return "bed.double"
        case "bathrooms":
            return "shower"
        case "full bathrooms":
            return "shower.fill"
        default:
            return "asterisk.circle"
        }
    }
}

extension Feature {
    var data: [Feature] {
        [
            Feature(name: "Bedrooms", value: "4"),
            Feature(name: "Bathrooms", value: "5"),
            Feature(name: "Full Bathrooms", value: "4"),

            //Heating
            Feature(name: "Heating feature", value: "Electric"),

            //Cooling
            Feature(name: "Cooling feature", value: "Refrigerated Central, Window Unit(s)"),

            //Other interior features
            Feature(name: "Total Structure area", value: "2077"),
            Feature(name: "Total interior liveable area", value: "2077"),
            Feature(name: "Total number of fireplace", value: "1"),

            //*Property Details
            //Parking
            Feature(name: "Total space", value: "1"),
            Feature(name: "", value: ""),

            //Utilities
            Feature(name: "Sewer", value: "Septic Tank"),
            Feature(name: "Water", value: "Public, Well"),

            //Location
            Feature(name: "Region", value: "Anthony"),
            Feature(name: "Subdivision", value: "Haciendas De Anthony")
        ]
    }
}
