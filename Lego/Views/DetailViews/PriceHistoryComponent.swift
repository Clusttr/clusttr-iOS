//
//  PriceHistoryComponent.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 25/04/2023.
//

import SwiftUI
import Charts

struct PriceHistoryComponent: View {
    var transactions: [cTransaction]
    var valuations: [Valuation]
    var body: some View {
        VStack {
            HStack {
                Text("Price History")
                    .font(.headline)
                Spacer()

                NavigationLink {
                    ScrollView(showsIndicators: false) {
                        TransactionList()
                    }
                    .background(Color._background)
                } label: {
                    HStack(spacing: 4) {
                        Text("Price History")
                        Image(systemName: "chevron.right")
                    }
                    .padding([.leading, .top, .bottom], 4)
                    .clipShape(Rectangle())
                    .font(.footnote)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
                }

            }

            let transactionAverage = transactions.yearlyAveragePrice()
            let transactionSortedYear = transactionAverage.map { $0.key }.sorted()
            let valuationAverage = valuations.yearlyAveragePrice()
            let valuationSortedYear = valuationAverage.map { $0.key }.sorted()

            Chart {

                ForEach(transactionSortedYear, id: \.self) { year in
                    LineMark(x: .value("Year", "\(year)"), y: .value("Value", transactionAverage[year, default: 0]), series: .value("Year", "Transaction"))
                        .cornerRadius(10)
                        .interpolationMethod(.cardinal)
                        .foregroundStyle(by: .value("Year", "Price"))
                        .symbol(by: .value("Year", "Price"))
                }

                ForEach(valuationSortedYear, id: \.self) { year in
                    LineMark(x: .value("Year", "\(year)"), y: .value("Value", valuationAverage[year, default: 0]), series: .value("Year", "Valuation"))
                        .cornerRadius(10)
                        .interpolationMethod(.cardinal)
                        .foregroundStyle(by: .value("Year", "Valuation"))
                        .symbol(by: .value("Year", "Valuation"))
                }
            }
            .frame(height: 300)
            .padding(.top, 16)
        }
        .padding(.horizontal, 24)
    }
}

struct PriceHistoryComponent_Previews: PreviewProvider {
    static var previews: some View {
        PriceHistoryComponent(transactions: cTransaction.data, valuations: Valuation.data)
    }
}
