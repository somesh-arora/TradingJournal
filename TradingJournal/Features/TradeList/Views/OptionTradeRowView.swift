//
//  OptionTradeRowView.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/25/21.
//

import SwiftUI
import CoreData

struct OptionTradeRowView: View {
    
    @StateObject var optionEntity: OptionEntity
    
    var body: some View {
        HStack(spacing: 0) {
            leftView
            Spacer()
            rightView
        }
        .padding()
        .background(Color.accentColor.opacity(0.08))
        .cornerRadius(8)
    }
    
    private var leftView: some View {
        VStack(alignment: .leading, spacing: 5) {
            titleView
            subtitleView
        }
    }
    
    private var titleView: some View {
        Text(optionEntity.stockSymbol ?? "")
    }
    
    private var subtitleView: some View {
        HStack(spacing: 5) {
            Text(optionEntity.strategy ?? "")
                .font(.caption)
            
            if optionEntity.contractCount > 1 {
                Text("x\(optionEntity.contractCount)")
                    .font(.system(size: 12))
                    .bold()
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color.theme.background.opacity(0.4))
                    )
            }
        }
    }
    
    @ViewBuilder
    private var rightView: some View {
        if optionEntity.isOpen {
            expirationDateView
        }
        
        if !optionEntity.isOpen {
            profileLossView
        }
    }
    
    private var expirationDateView: some View {
        HStack(spacing: 2) {
            Image(systemName: "hourglass")
            Text(Calendar.current.numberOfDaysBetween(Date(), and: optionEntity.expirationDate ?? Date()))
        }
    }
    
    private var profileLossView: some View {
        Text(getPLNumber())
            .font(.body)
            .bold()
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background(profitLossBackgroundView)
    }
    
    private var profitLossBackgroundView: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(optionEntity.profit_loss >= 0.0 ? Color.theme.green : Color.theme.red)
    }
    
    func getPLNumber() -> String {
        return Double(optionEntity.profit_loss).asCurrencyWith2Decimals()
    }
}

struct OptionTradeRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OptionTradeRowView(optionEntity: dev.openTrade)
                .previewLayout(.sizeThatFits)
                .environment(\.managedObjectContext, NSPersistentContainer(name: "OptionTrades").viewContext)
            
            OptionTradeRowView(optionEntity: dev.openTrade)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .environment(\.managedObjectContext, NSPersistentContainer(name: "OptionTrades").viewContext)
            
            OptionTradeRowView(optionEntity: dev.openTrade)
                .previewLayout(.sizeThatFits)
                .environment(\.managedObjectContext, NSPersistentContainer(name: "OptionTrades").viewContext)
            
            OptionTradeRowView(optionEntity: dev.openTrade)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .environment(\.managedObjectContext, NSPersistentContainer(name: "OptionTrades").viewContext)
        }
    }
}
