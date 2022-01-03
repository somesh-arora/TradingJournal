//
//  OptionEntityCalculationsHelper.swift
//  TradingJournal
//
//  Created by Somesh Arora on 1/1/22.
//

import Foundation

class OptionEntityCalculationsHelper {
    let shares_per_contract: Float = 100.0
    
    func calculatePL(for entity: OptionEntity) -> Float {
        let difference = getPriceDifference(entity)
        return difference * shares_per_contract * Float(entity.contractCount)
    }
    
    func calculatePLPercentage(for entity: OptionEntity) -> Float {
        let difference = getPriceDifference(entity)
        return (difference / entity.optionPrice_open) * 100
    }
    
    private func getPriceDifference(_ entity: OptionEntity) -> Float {
        guard let strategy = entity.strategy,
              let optionStrategy = OptionStrategy(rawValue: strategy) else {
                  return entity.optionPrice_close - entity.optionPrice_open
              }
        switch optionStrategy.premiumType {
        case .debit:
            return entity.optionPrice_close - entity.optionPrice_open
        case .credit:
            return entity.optionPrice_open - entity.optionPrice_close
        }
    }
}
