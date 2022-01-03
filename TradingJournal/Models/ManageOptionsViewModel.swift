//
//  ManageOptionsViewModel.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/31/21.
//

import Foundation
import Combine

/*
 CRUD Funtions
 Create
 Read
 Update
 Delete
 */

final class ManageOptionsViewModel: ObservableObject {
    
    @Published var optionEntities: [OptionEntity] = []
    
    @Published var selectedEntity: OptionEntity? = nil
    
    private let optionTradingService = OptionTradeService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        optionTradingService.$savedEntities
            .receive(on: DispatchQueue.main)
            .sink { [weak self] optionEntities in
                guard let self = self else { return }
                self.optionEntities = optionEntities
                
                if self.selectedEntity != nil,
                   let updatedEntity = optionEntities.first(where: { $0.id == self.selectedEntity?.id }) {
                    self.selectedEntity = updatedEntity
                }
            }
            .store(in: &cancellables)
    }
    
    func addNewPosition(_ position: NewPositionModel) {
        self.optionTradingService.addNewPosition(position)
    }
    
    func delete(_ entity: OptionEntity) {
        self.optionTradingService.delete(entity: entity)
    }
    
    func closePosition(_ entity: OptionEntity, data: ClosePositionModel) {
        self.optionTradingService.closeTrade(entity: entity, data: data)
    }
    
    func updatePosition(_ position: OptionEntity) {
        
    }
}
