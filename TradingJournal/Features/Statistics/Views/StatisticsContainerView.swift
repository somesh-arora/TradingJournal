//
//  StatisticsContainerView.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/28/21.
//

import SwiftUI

struct StatisticsContainerView: View {
    
    @EnvironmentObject private var viewModel: ManageOptionsViewModel
    
    let statisticsViewModel = StatisticsViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            LargeTitleView(title: "Statistics")
            statisticsView
        }
        .padding()
        .navigationBarHidden(true)
        .navigationTitle("")
    }
    
    private var statisticsView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                // stats grid
                StatsGridView(stats: statisticsViewModel.getStatsData(optionEntities: viewModel.optionEntities))
                
                // statistics grid
                CircularProgressGridView(data: statisticsViewModel.getProgressData(optionEntities: viewModel.optionEntities))
            }
        }
    }
}

struct StatisticsContainerView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsContainerView()
    }
}
