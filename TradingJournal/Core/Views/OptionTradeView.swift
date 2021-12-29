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
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                headerView
                if viewModel.optionTrades.isEmpty {
                    emptyView
                } else {
                    optionTradeList
                }
            }
            addButtonView
        }
        .ignoresSafeArea(.all, edges: .top)
        .sheet(isPresented: $viewModel.isNewTrade) {
            AddNewOptionView(viewModel: viewModel)
        }
        .background(
            NavigationLink(destination: OptionDetailLoadingView(optionEntity: $selectedOptionTrade),
                           isActive: $showDetailView,
                           label: { EmptyView() })
        )
    }
    
    private var headerView: some View {
        HStack {
            Text("Positions")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
            
            Spacer(minLength: 0)
        }
        .padding(.vertical)
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
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
                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                        .onTapGesture {
                            segue(optionTrade: optionTrade)
                        }
                }
            }
        }
    }
    
    private var addButtonView: some View {
        Button {
            viewModel.isNewTrade.toggle()
        } label: {
            Image(systemName: "plus")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(20)
                .background(
                    LinearGradient(gradient: .init(colors: [Color.theme.green.opacity(0.7), Color.theme.green, Color.theme.green.opacity(0.7)]), startPoint: .leading, endPoint: .trailing)
                )
                .clipShape(Circle())
        }
        .padding()
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
