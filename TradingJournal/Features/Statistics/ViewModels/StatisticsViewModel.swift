//
//  StatisticsViewModel.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/28/21.
//

import Foundation
import Combine
import SwiftUI

final class StatisticsViewModel: ObservableObject {
    
    func getProgressData(optionEntities: [OptionEntity]) -> [CircularProgressModel] {
        var circularProgressData: [CircularProgressModel] = []
        let profit_loss = profit_loss(optionEntities: optionEntities)
        circularProgressData.append(CircularProgressModel(header: "Goal", subheader: "Target: $10,000", currentValue: profit_loss, targetValue: 10000, progressColor: Color.accentColor, footer: "Current: \(Double(profit_loss).asCurrencyWith2Decimals())"))
//        circularProgressData.append(CircularProgressModel(header: "Goal", currentValue: 5000, targetValue: 10000, progressColor: Color.theme.newTrade, footer: "$10,000"))
//        circularProgressData.append(CircularProgressModel(header: "Goal", currentValue: 7200, targetValue: 10000, progressColor: Color.theme.newTrade, footer: "$10,000"))
        return circularProgressData
    }
    
    func getStatsData(optionEntities: [OptionEntity]) -> [StatsModel] {
        var statsData: [StatsModel] = []
        statsData.append(StatsModel(title: "Total Trades", value: self.totalTrades(optionEntities: optionEntities)))
        statsData.append(StatsModel(title: "Open Trades", value: self.openTrades(optionEntities: optionEntities)))
        statsData.append(StatsModel(title: "Total Contracts", value: self.totalContracts(optionEntities: optionEntities)))
        statsData.append(StatsModel(title: "Win Percentage", value: winPercentage(optionEntities: optionEntities)))
        statsData.append(StatsModel(title: "Biggest Win", value: self.biggestWin(optionEntities: optionEntities)))
        statsData.append(StatsModel(title: "Biggest Loss", value: self.biggestLoss(optionEntities: optionEntities)))
        statsData.append(StatsModel(title: "Average P/L", value: averagePL(optionEntities: optionEntities)))
        return statsData
    }
    
    private func profit_loss(optionEntities: [OptionEntity]) -> CGFloat {
        let closedTrades = optionEntities.filter { !$0.isOpen }
        let profit_loss = closedTrades.map { $0.profit_loss }.reduce(0, +)
        return CGFloat(profit_loss)
    }
    
    private func totalTrades(optionEntities: [OptionEntity]) -> String {
        return "\(optionEntities.count)"
    }
    
    private func openTrades(optionEntities: [OptionEntity]) -> String {
        return "\(optionEntities.filter { $0.isOpen }.count)"
    }
    
    private func totalContracts(optionEntities: [OptionEntity]) -> String {
        return "\(optionEntities.map { $0.contractCount }.reduce(0, +))"
    }
    
    private func biggestWin(optionEntities: [OptionEntity]) -> String {
        let winningTrades = optionEntities.map { $0.profit_loss }.filter { $0 > 0.0 }
        guard winningTrades.count > 0 else {
            return "N/A"
        }
        return Double(winningTrades.max() ?? 0.0).asCurrencyWith2Decimals()
    }
    
    private func biggestLoss(optionEntities: [OptionEntity]) -> String {
        let losingTrades = optionEntities.map { $0.profit_loss }.filter { $0 < 0.0 }
        guard losingTrades.count > 0 else {
            return "N/A"
        }
        return Double(losingTrades.min() ?? 0.0).asCurrencyWith2Decimals()
    }
    
    private func averagePL(optionEntities: [OptionEntity]) -> String {
        let closedTrades = optionEntities.filter { !$0.isOpen }
        let profit_loss = closedTrades.map { $0.profit_loss }.reduce(0, +)
        let averagePL = Double(profit_loss) / Double(closedTrades.count)
        return averagePL.asCurrencyWith2Decimals()
    }
    
    private func winPercentage(optionEntities: [OptionEntity]) -> String {
        let closedTrades = optionEntities.filter { !$0.isOpen }
        let profitableTrades = closedTrades.map { $0.profit_loss }.filter { $0 > 0.0 }
        guard closedTrades.count > 0 else {
            return "N/A"
        }
        let percentage = Double((Double(profitableTrades.count) / Double(closedTrades.count)) * 100)
        return percentage.asPercentString()
    }
}
