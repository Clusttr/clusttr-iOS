//
//  TokenCategoryPicker.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 12/09/2023.
//

import SwiftUI

enum PropertyCategory: String, Identifiable, CaseIterable {
    case recent
    case popular
    case bestseller

    var id: String {
        self.rawValue
    }
}

struct TokenCategoryPicker: View {
    @Binding var activeCategory: PropertyCategory

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(PropertyCategory.allCases) { item in
                    Button {
                        activeCategory = item
                    } label: {
                        Text(item.rawValue.capitalized)
                            .fontWeight(.medium)
                            .foregroundColor(item == activeCategory ? ._background : .white)
                            .frame(height: 47)
                            .padding(.horizontal, 28)
                            .background(item == activeCategory ? .white : ._grey700)
                            .clipShape(RoundedRectangle(cornerRadius: 65))
                    }
                }
            }
            .padding(.horizontal, 30)
        }
    }
}

struct TokenCategoryPicker_Previews: PreviewProvider {
    static var previews: some View {
        TokenCategoryPicker(activeCategory: .constant(.bestseller))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color._background)
    }
}
