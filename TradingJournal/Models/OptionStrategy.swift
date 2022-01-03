//
//  OptionStrategy.swift
//  TradingJournal
//
//  Created by Somesh Arora on 1/1/22.
//

import Foundation
import SwiftUI

enum OptionStrategy: String, CaseIterable {
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
    
    var premiumType: OptionPremiumType {
        switch self {
        case .longCall: return .debit
        case .longPut: return .debit
        case .coveredCall: return .credit
        case .cashSecuredPut: return .credit
        case .putCreditSpread: return .credit
        case .callCreditSpread: return .credit
        case .callDebitSpread: return .debit
        case .putDebitSpread: return .debit
        case .ironButterfly: return .credit
        case .ironCondor: return .credit
        case .longPutButterfly: return .debit
        case .longCallButterfly: return .debit
        case .inverseIronButterfly: return .debit
        case .inverseIronCondor: return .debit
        case .straddle: return .debit
        case .strangle: return .debit
        case .collar: return .debit
        case .poorManCoveredCall: return .debit
        case .diagonalPutSpread: return .debit
        }
    }
}
