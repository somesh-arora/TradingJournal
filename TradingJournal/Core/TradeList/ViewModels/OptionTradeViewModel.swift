//
//  OptionTradeViewModel.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/25/21.
//

import Foundation
import Combine

class OptionTradeViewModel: ObservableObject {
    
    @Published var optionTrades: [OptionEntity] = []
    
    private let optionTradeService = OptionTradeService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addNewOptionTrade(data: NewOptionModel) {
        optionTradeService.add(data: data)
    }
    
    func addSubscribers() {
        optionTradeService.$savedEntities
            .receive(on: RunLoop.main)
            .sink { [weak self] optionEntites in
            self?.optionTrades = optionEntites
        }
        .store(in: &cancellables)
    }
}