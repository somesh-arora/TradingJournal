//
//  StatsView.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/28/21.
//

import SwiftUI

struct StatsView: View {
    
    let stat: StatsModel
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .center, spacing: 8) {
                titleView
                valueView
                if stat.percentageChange != nil {
                    percentageChangeView
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .background(Color.accentColor.opacity(0.05))
        .cornerRadius(16)
    }
    
    private var titleView: some View {
        Text(stat.title)
            .font(.caption)
            .multilineTextAlignment(.center)
            .foregroundColor(Color.gray)
    }
    
    private var valueView: some View {
        Text(stat.value)
            .font(.headline)
            .multilineTextAlignment(.leading)
    }
    
    private var percentageChangeView: some View {
        HStack(spacing: 4) {
            Image(systemName: "triangle.fill")
                .font(.caption2)
                .rotationEffect(
                    Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180)
                )
            Text(stat.percentageChange?.asPercentString() ?? "")
                .font(.caption)
                .bold()
        }
        .foregroundColor((stat.percentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
        .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatsView(stat: dev.stat1)
                .previewLayout(.sizeThatFits)
            
            StatsView(stat: dev.stat2)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
            
            StatsView(stat: dev.stat3)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
            
            StatsView(stat: dev.stat4)
                .previewLayout(.sizeThatFits)
        }
    }
}
