//
//  OptionStrategies.swift
//  TradingJournal
//
//  Created by Somesh Arora on 1/1/22.
//

import Foundation
import SwiftUI

enum OptionStrategies: String, CaseIterable {
    case longCall = "Long Call"
    case longPut = "Long Put"
    case coveredCall = "Covered Call"
    case cashSecuredPut = "Cash-Secured Put"
    case putCreditSpread = "Put Credit Spread"
    case callCreditSpread = "Call Credit Spread"
    case callDebitSpread = "Call Debit Spread"
    case putDebitSpread = "Put Debit Spread"
    case ironButterfly = "Iron Butterfly"
    case ironCondor = "Iron Condor"
    case longPutButterfly = "Long Put Butterfly"
    case longCallButterfly = "Long Call Butterfly"
    case inverseIronButterfly = "Inverse Iron Butterfly"
    case inverseIronCondor = "Inverse Iron Condor"
    case straddle = "Straddle"
    case strangle = "Strangle"
    case collar = "Collar"
    case poorManCoveredCall = "Poor Man's Covered Call"
    case diagonalPutSpread = "Diagonal Put Spread"
}
