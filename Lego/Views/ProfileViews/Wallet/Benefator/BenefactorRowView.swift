//
//  BenefactorRow.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/07/2023.
//

import SwiftUI

struct BenefactorRow: View {
    @State var isSheetPresented = false
    @State private var fullSheetExpanded: Bool = false

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 18) {
                
                Button(action: addBenefactor) {
                    Image(systemName: "plus")
                        .font(.system(size: 24, design: .rounded))
                        .fontWeight(.semibold)
                        .frame(width: 45, height: 45)
                        .foregroundColor(._grey100)
                        .background {
                            LinearGradient(colors: [Color._accent.opacity(0.7), .pink.opacity(0.4)], startPoint: .topTrailing, endPoint: .bottomLeading)
                        }
                        .clipShape(Circle())
                        .padding(.leading, 16)
                }

                ForEach(0 ..< 5) { item in
                    BenefactorCard()
                        .padding(.vertical, 4)
                }
            }
            .padding(.trailing, 16)
        }
        .sheet(isPresented: $isSheetPresented) {
            AddBenefactorView(
                isSheetPresented: $isSheetPresented,
                fullSheetExpanded: $fullSheetExpanded
            )
            .presentationDetents([.height(fullSheetExpanded ? .infinity : 250)])
        }
    }

    func addBenefactor() {
        isSheetPresented = true
    }
}

struct BenefactorRow_Previews: PreviewProvider {
    static var previews: some View {
        BenefactorRow()
            .background(Color._background)
    }
}
