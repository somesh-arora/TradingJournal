//
//  OptionTradeService.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/25/21.
//

import Foundation
import CoreData

class OptionTradeService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "OptionTrades"
    private let entityName: String = "OptionEntity"
    
    @Published var savedEntities: [OptionEntity] = []
    
    typealias Utils = OptionEntityCalculationsHelper
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("error loading core data: \(error)")
            } else {
                self.getOptionTrades()
            }
        }
    }
}

// MARK: Public Methods
extension OptionTradeService {
    func updateOptionTrade() {
        // TODO: call add, update, delete
    }
}

// MARK: Private Methods
extension OptionTradeService {
    private func getOptionTrades() {
        let request = NSFetchRequest<OptionEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("error fetching option trade entity: \(error)")
        }
    }
    
    func addNewPosition(_ position: NewPositionModel) {
        let entity = OptionEntity(context: container.viewContext)
        entity.id = position.id
        entity.stockSymbol = position.stockSymbol
        entity.strategy = position.strategy
        if let optionPrice_open = Float(position.optionPrice_open) {
            entity.optionPrice_open = optionPrice_open
        }
        //        if let stockPrice_open = Float(position.stockPrice_open) {
        //            entity.stockPrice_open = stockPrice_open
        //        }
        //        if let collateral = Float(position.collateral) {
        //            entity.collateral = collateral
        //        }
        if let contractCount = Int16(position.contractCount) {
            entity.contractCount = contractCount
        }
        entity.openDate = position.openDate
        entity.expirationDate = position.expirationDate
        entity.isOpen = true
        applyChanges()
    }
    
    func closeTrade(entity: OptionEntity, data: ClosePositionModel) {
        guard let entity = savedEntities.first(where: { $0.id == entity.id }), entity.isOpen else {
            print("Cannot find entity")
            return
        }
        if let optionPrice_close = Float(data.optionPrice_close) {
            entity.optionPrice_close = optionPrice_close
        }
        entity.closeDate = data.closeDate
        entity.profit_loss = Utils().calculatePL(for: entity)
        entity.profit_loss_percentage = Utils().calculatePLPercentage(for: entity)
        //        if let stockPrice_close = Float(data.stockPrice_close) {
        //            currentEntity.stockPrice_close = stockPrice_close
        //        }
        
        entity.isOpen = false
        applyChanges()
    }
    
    private func update(entity: OptionEntity) {
        // TODO: Update values
        applyChanges()
    }
    
    func delete(entity: OptionEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("error saving to core data: \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getOptionTrades()
    }
}
