//
//  PreviewProvider.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/25/21.
//

import Foundation
import SwiftUI
import CoreData

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    
    private init() { }
    
    let manageOptionsViewModel = ManageOptionsViewModel()
    
    let optionDetailViewModel = OptionDetailViewModel()
    
    let circularProgressModel = CircularProgressModel(header: "Target", subheader: "$10,000", currentValue: 2000, targetValue: 10000, progressColor: Color.theme.accent, footer: "Current: $2,000")
    
    let openTrade: OptionEntity = {
        let item = OptionEntity(context: NSPersistentContainer(name: "OptionTrades").viewContext)
        item.stockSymbol = "TSLA"
        item.strategy = "Put Credit Spread"
        item.expirationDate = Date.from(year: 2021, month: 12, day: 31)
        item.contractCount = 10
        item.isOpen = true
        return item
    }()
    
    let closedTrade: OptionEntity = {
        let item = OptionEntity(context: NSPersistentContainer(name: "OptionTrades").viewContext)
        item.stockSymbol = "AAPL"
        item.strategy = "Put Credit Spread"
        item.contractCount = 10
        item.optionPrice_open = 11.90
        item.optionPrice_close = 0.20
        item.isOpen = false
        return item
    }()
    
    let stat1 = StatsModel(title: "Most Profitable Trade", value: "$10,252")
    let stat2 = StatsModel(title: "Total Trades", value: "234")
    let stat3 = StatsModel(title: "Average Amount Per Trade", value: "$10.23")
    let stat4 = StatsModel(title: "Win Percentage", value: "69.3%")
    
    let statistic1 = StatsModel(title: "Market Cap", value: "$12.5Bn", percentageChange: 25.23)
    let statistic2 = StatsModel(title: "Total Volume", value: "$1.234Tn")
    let statistic3 = StatsModel(title: "Portfolio Value", value: "$12.24k", percentageChange: -12.34)
}
