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
        circularProgressData.append(CircularProgressModel(header: "Goal", currentValue: 1200, targetValue: 10000, progressColor: Color.theme.newTrade, footer: "$10,000"))
        circularProgressData.append(CircularProgressModel(header: "Goal", currentValue: 5000, targetValue: 10000, progressColor: Color.theme.newTrade, footer: "$10,000"))
        circularProgressData.append(CircularProgressModel(header: "Goal", currentValue: 7200, targetValue: 10000, progressColor: Color.theme.newTrade, footer: "$10,000"))
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
        let profit_loss = optionEntities.map { $0.profit_loss }
        return Double(profit_loss.max() ?? 0.0).asCurrencyWith2Decimals()
    }
    
    private func biggestLoss(optionEntities: [OptionEntity]) -> String {
        let profit_loss = optionEntities.map { $0.profit_loss }
        return Double(profit_loss.min() ?? 0.0).asCurrencyWith2Decimals()
    }
    
    private func averagePL(optionEntities: [OptionEntity]) -> String {
        let averageReturn = optionEntities.map { $0.profit_loss }.reduce(0, +)
        return Double(averageReturn).asCurrencyWith2Decimals()
    }
    
    private func winPercentage(optionEntities: [OptionEntity]) -> String {
        guard optionEntities.count > 0 else {
            return "N/A"
        }
        let totalTrades = Double(optionEntities.count)
        let winningTrades = Double(optionEntities.map { $0.profit_loss }.filter { $0 >= 0.0 }.count)
        let percentage = Double((winningTrades / totalTrades) * 100)
        return percentage.asPercentString()
    }
}
