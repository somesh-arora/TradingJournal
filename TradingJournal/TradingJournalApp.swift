//
//  TradingJournalApp.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/25/21.
//

import SwiftUI

@main
struct TradingJournalApp: App {
    
    @StateObject private var viewModel = OptionTradeViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                OptionTradeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(viewModel)
        }
    }
}
