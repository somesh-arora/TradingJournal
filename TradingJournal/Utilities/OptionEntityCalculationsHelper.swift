//
//  OptionEntityCalculationsHelper.swift
//  TradingJournal
//
//  Created by Somesh Arora on 1/1/22.
//

import Foundation

class OptionEntityCalculationsHelper {
    func calculatePL(for entity: OptionEntity) -> Float {
        let difference = entity.optionPrice_open - entity.optionPrice_close
        return difference * 100.0 * Float(entity.contractCount)
    }
    
    func calculatePLPercentage(for entity: OptionEntity) -> Float {
        let difference = entity.optionPrice_open - entity.optionPrice_close
        return difference * Float(entity.contractCount)
    }
}
