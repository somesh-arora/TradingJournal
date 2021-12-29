//
//  StatisticsContainerView.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/28/21.
//

import SwiftUI

struct StatisticsContainerView: View {
    
    let viewModel: StatisticsViewModel
    
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
                StatsGridView(stats: viewModel.statsData)
                
                // statistics grid
                CircularProgressGridView(data: viewModel.circularProgressData)
            }
        }
    }
}

struct StatisticsContainerView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsContainerView(viewModel: StatisticsViewModel())
    }
}
