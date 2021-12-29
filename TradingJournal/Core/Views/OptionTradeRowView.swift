//
//  OptionTradeRowView.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/25/21.
//

import SwiftUI
import CoreData

struct OptionTradeRowView: View {
    
    let optionTrade: OptionEntity
    
    var body: some View {
        HStack(spacing: 0) {
            leftView
            Spacer(minLength: 10)
            rightView
        }
        .padding()
    }
    
    private var leftView: some View {
        VStack(alignment: .leading, spacing: 5) {
            titleView
            subtitleView
        }
    }
    
    private var titleView: some View {
        Text(optionTrade.stockSymbol ?? "")
    }
    
    private var subtitleView: some View {
        HStack(spacing: 5) {
            Text(optionTrade.strategy ?? "")
                .font(.caption)
            Text("x\(optionTrade.contractCount)")
                .font(.system(size: 10))
                .bold()
                .padding(.horizontal, 5)
                .padding(.vertical, 4)
                .background(
                    Capsule()
                        .fill(Color.teal.opacity(0.6))
                )
        }
    }
    
    @ViewBuilder
    private var rightView: some View {
        if optionTrade.isOpen {
            expirationDateView
        }
        
        if !optionTrade.isOpen {
            profileLossView
        }
    }
    
    private var expirationDateView: some View {
        HStack(spacing: 2) {
            Image(systemName: "hourglass")
            Text(Calendar.current.numberOfDaysBetween(Date(), and: optionTrade.expirationDate ?? Date()))
        }
    }
    
    private var profileLossView: some View {
        Text(getPLNumber())
            .font(.body)
            .bold()
            .padding(.horizontal, 5)
            .padding(.vertical, 3)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(optionTrade.optionPrice_open - optionTrade.optionPrice_close > 0.0 ? Color.theme.green : Color.theme.red)
            )
    }
    
    func getPLNumber() -> String {
        let difference = optionTrade.optionPrice_open - optionTrade.optionPrice_close
        let actualPrice = difference * 100.0 * Float(optionTrade.contractCount)
        return Double(actualPrice).asCurrencyWith2Decimals()
    }
}

struct OptionTradeRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OptionTradeRowView(optionTrade: dev.openTrade)
                .previewLayout(.sizeThatFits)
                .environment(\.managedObjectContext, NSPersistentContainer(name: "OptionTrades").viewContext)
            
            OptionTradeRowView(optionTrade: dev.openTrade)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .environment(\.managedObjectContext, NSPersistentContainer(name: "OptionTrades").viewContext)
            
            OptionTradeRowView(optionTrade: dev.closedTrade)
                .previewLayout(.sizeThatFits)
                .environment(\.managedObjectContext, NSPersistentContainer(name: "OptionTrades").viewContext)
            
            OptionTradeRowView(optionTrade: dev.closedTrade)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .environment(\.managedObjectContext, NSPersistentContainer(name: "OptionTrades").viewContext)
        }
        
    }
}
