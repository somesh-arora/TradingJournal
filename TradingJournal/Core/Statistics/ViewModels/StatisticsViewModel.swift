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
    
    @Published var circularProgressData: [CircularProgressModel] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        circularProgressData.append(CircularProgressModel(header: "Goal", currentValue: 1200, targetValue: 10000, progressColor: Color.theme.newTrade, footer: "$10,000"))
        circularProgressData.append(CircularProgressModel(header: "Goal", currentValue: 5000, targetValue: 10000, progressColor: Color.theme.newTrade, footer: "$10,000"))
        circularProgressData.append(CircularProgressModel(header: "Goal", currentValue: 7200, targetValue: 10000, progressColor: Color.theme.newTrade, footer: "$10,000"))
    }
}
