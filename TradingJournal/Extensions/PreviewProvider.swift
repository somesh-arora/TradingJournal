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
    
    let optionTradeViewModel = OptionTradeViewModel()
    
    let optionDetailViewModel = OptionDetailViewModel(optionEntity: instance.openTrade)
    
    let openTrade: OptionEntity = {
        let item = OptionEntity(context: NSPersistentContainer(name: "OptionTrades").viewContext)
        item.ticker = "TSLA"
        item.strategy = "Put Credit Spread"
        item.expirationDate = Date.from(year: 2021, month: 12, day: 31)
        item.contractCount = 10
        item.isOpen = true
        return item
    }()
    
    let closedTrade: OptionEntity = {
        let item = OptionEntity(context: NSPersistentContainer(name: "OptionTrades").viewContext)
        item.ticker = "AAPL"
        item.strategy = "Put Credit Spread"
        item.contractCount = 10
        item.openPrice = 11.90
        item.closePrice = 0.20
        item.isOpen = false
        return item
    }()
    
    let newPosition = NewPositionModel(ticker: "TSLA", strategy: "Put Credit Spread", openDate: Date(), expirationDate: Date(), closeDate: nil, openPrice: 1.9, closePrice: 0.2, numberOfContracts: 1)
    
    let statistic1 = StatisticModel(title: "Market Cap", value: "$12.5Bn", percentageChange: 25.23)
    let statistic2 = StatisticModel(title: "Total Volume", value: "$1.234Tn")
    let statistic3 = StatisticModel(title: "Portfolio Value", value: "$12.24k", percentageChange: -12.34)
}
