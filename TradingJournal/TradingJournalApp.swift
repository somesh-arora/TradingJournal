//
//  TradingJournalApp.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/25/21.
//

import SwiftUI

@main
struct TradingJournalApp: App {
    
    @StateObject private var viewModel = ManageOptionsViewModel()
    
    init() {
     setup()
    }
    
    private func setup() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        
        UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().separatorColor = .clear
        UITableView.appearance().showsVerticalScrollIndicator = false
        
        UITableViewCell.appearance().backgroundColor = .clear
        
        UITabBar.appearance().isHidden = true
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TabBarView()
                    .navigationBarHidden(true)
            }
            .environmentObject(viewModel)
        }
    }
}
