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
        statsData.append(StatsModel(title: "Most Profitable Trade", value: "$10,252"))
        statsData.append(StatsModel(title: "Total Trades", value: self.totalTrades(optionEntities: optionEntities)))
        statsData.append(StatsModel(title: "Total Contracts", value: self.totalContracts(optionEntities: optionEntities)))
        statsData.append(StatsModel(title: "Average Amount Per Trade", value: "$10.23"))
        statsData.append(StatsModel(title: "Win Percentage", value: "69.3%"))
        return statsData
    }
    
    private func totalTrades(optionEntities: [OptionEntity]) -> String {
        return "\(optionEntities.count)"
    }
    
    private func totalContracts(optionEntities: [OptionEntity]) -> String {
        return "\(optionEntities.map { $0.contractCount }.reduce(0, +))"
    }
}
