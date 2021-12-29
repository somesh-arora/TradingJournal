//
//  StatsModel.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/28/21.
//

import Foundation

struct StatsModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}
