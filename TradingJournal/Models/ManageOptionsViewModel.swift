//
//  ManageOptionsViewModel.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/31/21.
//

import Foundation
import Combine


final class ManageOptionsViewModel: ObservableObject {
    
    @Published var optionEntities: [OptionEntity] = []
    
    private let optionTradingService = OptionTradeService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        optionTradingService.$savedEntities
            .receive(on: RunLoop.main)
            .sink { [weak self] optionEntities in
                self?.optionEntities = optionEntities
            }
            .store(in: &cancellables)
    }
    
    func addNewPosition(_ position: NewPositionModel) {
        self.optionTradingService.addNewPosition(position)
    }
    
    func deletePosition(_ position: OptionEntity) {
        
    }
    
    func closePosition(_ position: OptionEntity) {
        
    }
    
    func updatePosition(_ position: OptionEntity) {
        
    }
}
