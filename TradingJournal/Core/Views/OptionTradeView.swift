//
//  OptionTradeView.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/25/21.
//

import SwiftUI

struct OptionTradeView: View {
    
    @EnvironmentObject private var viewModel: OptionTradeViewModel
    
    @State private var selectedOptionTrade: OptionEntity? = nil
    @State private var showDetailView: Bool = false
    
    var body: some View {
        VStack(spacing: 10) {
            headerView
            if viewModel.optionTrades.isEmpty {
                emptyView
            } else {
                optionTradeList
            }
        }
        .padding()
        .background(
            NavigationLink(destination: OptionDetailLoadingView(optionEntity: $selectedOptionTrade),
                           isActive: $showDetailView,
                           label: { EmptyView() })
        )
        .navigationBarHidden(true)
        .navigationTitle("")
    }
    
    private var headerView: some View {
        HStack {
            Text("Positions")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
            
            Spacer(minLength: 0)
        }
    }
    
    private var emptyView: some View {
        VStack {
            Spacer()
            Text("No positions yet! tap add button to get started")
                .font(.title)
                .padding(.horizontal, 30)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
    
    private var optionTradeList: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 8) {
                ForEach(viewModel.optionTrades) { optionTrade in
                    OptionTradeRowView(optionTrade: optionTrade)
                        .padding(5)
                        .background(Color.white)
                        .cornerRadius(18)
                        .onTapGesture {
                            segue(optionTrade: optionTrade)
                        }
                }
            }
        }
    }
    
    private func segue(optionTrade: OptionEntity) {
        selectedOptionTrade = optionTrade
        showDetailView.toggle()
    }
}

struct OptionTradeViews_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            OptionTradeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.optionTradeViewModel)
        
    }
}
