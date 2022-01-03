//
//  OptionDetailViewModel.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/25/21.
//

import Foundation
import Combine

final class OptionDetailViewModel: ObservableObject {
    
    func getStatisticArray(entity: OptionEntity?) -> [StatsModel] {
        
        guard let entity = entity else {
            return []
        }

        var statisticsArray: [StatsModel] = []
        
        if let ticker = entity.stockSymbol {
            statisticsArray.append( StatsModel(title: "Symbol", value: ticker))
        }
        
        if let strategy = entity.strategy {
            statisticsArray.append( StatsModel(title: "Strategy", value: strategy))
        }
        
        statisticsArray.append( StatsModel(title: "Status", value: entity.isOpen ? "Open" : "Closed"))
        
        statisticsArray.append( StatsModel(title: "Contracts", value: "\(entity.contractCount)"))
        
        statisticsArray.append( StatsModel(title: "Open Price", value: Double(entity.optionPrice_open).asCurrencyWith2Decimals()))
        
        if !entity.isOpen {
            statisticsArray.append( StatsModel(title: "Close Price", value: Double(entity.optionPrice_close).asCurrencyWith2Decimals()))
        }
        
        if let openDate = entity.openDate {
            statisticsArray.append( StatsModel(title: "Opened On", value: openDate.mediumStyleFormatting()))
        }
        
        if let expirationDate = entity.expirationDate {
            statisticsArray.append( StatsModel(title: entity.isOpen ? "Expires On" : "Expired on", value: expirationDate.mediumStyleFormatting()))
        }
        
        if !entity.isOpen, let closeDate = entity.closeDate {
            statisticsArray.append( StatsModel(title: "Closed On", value: closeDate.mediumStyleFormatting()))
        }
        
        if !entity.isOpen {
            statisticsArray.append(StatsModel(title: "P/L", value: Double(entity.profit_loss).asCurrencyWith2Decimals()))
            statisticsArray.append(StatsModel(title: "P/L Percentage", value: Double(entity.profit_loss_percentage).asPercentString()))
        }
        
        return statisticsArray
    }
}
