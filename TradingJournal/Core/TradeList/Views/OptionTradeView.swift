//
//  OptionTradeView.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/25/21.
//

import SwiftUI

struct OptionTradeView: View {
    
    @EnvironmentObject private var viewModel: ManageOptionsViewModel
    
    @State private var selectedOptionTrade: OptionEntity? = nil
    @State private var showDetailView: Bool = false
    
    var body: some View {
        VStack(spacing: 10) {
            LargeTitleView(title: "Positions")
            if viewModel.optionEntities.isEmpty {
                emptyView
            } else {
                optionTradeList
            }
        }
        .padding([.horizontal, .top])
        .background(
            NavigationLink(destination: OptionDetailLoadingView(optionEntity: $selectedOptionTrade),
                           isActive: $showDetailView,
                           label: { EmptyView() })
        )
        .navigationBarHidden(true)
        .navigationTitle("")
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
        List {
            ForEach(viewModel.optionEntities) { optionTrade in
                OptionTradeRowView(optionTrade: optionTrade)
                    .listRowInsets(.init(top: 6, leading: 0, bottom: 6, trailing: 0))
                    .listRowBackground(Color.clear)
                    .onTapGesture {
                        segue(optionTrade: optionTrade)
                    }
//                    .swipeActions {
//                        Button("Burn") {
//                            print("Right on!")
//                        }
//                        .tint(.red)
//                    }
            }
        }
        .listStyle(.plain)
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
        .environmentObject(dev.manageOptionsViewModel)
        
    }
}
