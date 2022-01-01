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
        entity.id = UUID()
        entity.stockSymbol = position.stockSymbol
        entity.strategy = position.strategy
        if let optionPrice_open = Float(position.optionPrice_open) {
            entity.optionPrice_open = optionPrice_open
        }
        if let stockPrice_open = Float(position.stockPrice_open) {
            entity.stockPrice_open = stockPrice_open
        }
        if let collateral = Float(position.collateral) {
            entity.collateral = collateral
        }
        entity.contractCount = Int16(position.contractCount)
        entity.openDate = position.openDate
        entity.expirationDate = position.expirationDate
        entity.isOpen = true
        applyChanges()
    }
    
    func closeTrade(entity: OptionEntity, data: CloseOptionTradeModel) {
        guard let currentEntity = savedEntities.first(where: { $0.id == entity.id }), currentEntity.isOpen else {
            print("Cannot find entity")
            return
        }
        if let closePrice = Float(data.closingPrice) {
            currentEntity.optionPrice_close = closePrice
        }
        currentEntity.closeDate = data.closingDate
        currentEntity.isOpen = false
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
