//
//  TabBarItems.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/28/21.
//

import Foundation
import SwiftUI

enum TabBarItems: CaseIterable {
    case home
    case newTrade
    case statistics
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .newTrade:
            return "NewTrade"
        case .statistics:
            return "Statistics"
        }
    }
    
    var imageName: String {
        switch self {
        case .home:
            return "house"
        case .newTrade:
            return "plus"
        case .statistics:
            return "chart.line.uptrend.xyaxis"
        }
    }
}
