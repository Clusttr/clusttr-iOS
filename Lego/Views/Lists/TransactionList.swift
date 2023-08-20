//
//  TransactionList.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 10/05/2023.
//

import SwiftUI

struct TransactionList: View {
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0 ..< 5) { item in
                TransactionItem()
                Rectangle()
                    .frame(height: 0.5)
                    .foregroundColor(.white.opacity(0.3))
            }
        }
    }
}

struct TransactionList_Previews: PreviewProvider {
    static var previews: some View {
        TransactionList()
    }
}
