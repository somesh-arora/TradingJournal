//
//  StatsGridView.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/28/21.
//

import SwiftUI

struct StatsGridView: View {
    
    let stats: [StatsModel]
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
            ForEach(stats) { stat in
                StatsView(stat: stat)
            }
        }
        .padding()
    }
}

struct StatsGridView_Previews: PreviewProvider {
    static var previews: some View {
        StatsGridView(stats: [dev.stat1, dev.stat2, dev.stat3, dev.stat4])
    }
}
