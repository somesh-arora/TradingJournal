//
//  NewPositionModel.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/25/21.
//

import Foundation

struct NewPositionModel: Identifiable {
    let id = UUID().uuidString
    let ticker: String
    let strategy: String
    let openDate: Date
    let expirationDate: Date
    let closeDate: Date?
    let openPrice: Double
    let closePrice: Double?
    let numberOfContracts: Int
}
