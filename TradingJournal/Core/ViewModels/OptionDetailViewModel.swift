//
//  OptionDetailViewModel.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/25/21.
//

import Foundation
import Combine

class OptionDetailViewModel: ObservableObject {
    
    @Published var statistics: [StatisticModel] = []
    @Published var optionEntity: OptionEntity
    
    private let optionTradeService = OptionTradeService()
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var showClosingTradeView: Bool = false
    
    init(optionEntity: OptionEntity) {
        self.optionEntity = optionEntity
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        $optionEntity
            .map(createStatisticArray)
            .sink { [weak self] statistics in
                self?.statistics = statistics
            }
            .store(in: &cancellables)
    }
    
    func closeOptionTrade(data: CloseOptionTradeModel) {
        optionTradeService.closeTrade(entity: optionEntity, data: data)
        showClosingTradeView.toggle()
    }
    
    private func createStatisticArray(entity: OptionEntity) -> [StatisticModel] {
        var statisticsArray: [StatisticModel] = []
        
        if let ticker = entity.stockSymbol {
            statisticsArray.append( StatisticModel(title: "Symbol", value: ticker))
        }
        
        if let strategy = entity.strategy {
            statisticsArray.append( StatisticModel(title: "Strategy", value: strategy))
        }
        
        statisticsArray.append( StatisticModel(title: "Status", value: entity.isOpen ? "Open" : "Closed"))
        
        statisticsArray.append( StatisticModel(title: "Contracts", value: "\(entity.contractCount)"))
        
        statisticsArray.append( StatisticModel(title: "Open Price", value: Double(entity.optionPrice_open).asCurrencyWith2Decimals()))
        
        if !entity.isOpen {
            statisticsArray.append( StatisticModel(title: "Close Price", value: Double(entity.optionPrice_close).asCurrencyWith2Decimals()))
        }
        
        if let openDate = entity.openDate {
            statisticsArray.append( StatisticModel(title: "Opened On", value: openDate.mediumStyleFormatting()))
        }
        
        if let expirationDate = entity.expirationDate {
            statisticsArray.append( StatisticModel(title: entity.isOpen ? "Expires On" : "Expired on", value: expirationDate.mediumStyleFormatting()))
        }
        
        if let closeDate = entity.closeDate, !entity.isOpen {
            statisticsArray.append( StatisticModel(title: "Closed On", value: closeDate.mediumStyleFormatting()))
        }
        
        if !entity.isOpen {
            let difference = entity.optionPrice_open - entity.optionPrice_close
            let actualPrice = difference * 100.0 * Float(entity.contractCount)
            
            statisticsArray.append(StatisticModel(title: "P/L", value: Double(actualPrice).asCurrencyWith2Decimals()))
        }
        return statisticsArray
    }
}
