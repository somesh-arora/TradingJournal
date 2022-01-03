//
//  OptionTradeView.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/25/21.
//

import SwiftUI

struct OptionTradeView: View {
    
    @EnvironmentObject private var viewModel: ManageOptionsViewModel
    
    @State private var showDetailView: Bool = false
    
    var body: some View {
        VStack(spacing: 10) {
            if viewModel.optionEntities.isEmpty {
                EmptyOptionsListView()
//                    .transition(.opacity.animation(.easeInOut))
//                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                LargeTitleView(title: "Positions")
                optionTradeList
            }
        }
        .padding([.horizontal, .top])
        .background(optionDetailView)
        .navigationBarHidden(true)
        .navigationTitle("")
    }
    
    @ViewBuilder
    private var optionDetailView: some View {
        if viewModel.selectedEntity != nil {
            NavigationLink(isActive: $showDetailView) {
                OptionDetailView()
            } label: {
                EmptyView()
            }
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
        List {
            ForEach(viewModel.optionEntities) { entity in
                OptionTradeRowView(optionEntity: entity)
                    .listRowInsets(.init(top: 6, leading: 0, bottom: 6, trailing: 0))
                    .listRowBackground(Color.clear)
                    .onTapGesture {
                        segue(selectedEntity: entity)
                    }
                    .transition(.move(edge: .trailing))
                    .swipeActions(allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            viewModel.delete(entity)
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    }
            }
        }
        .listStyle(.plain)
    }
    
    private func segue(selectedEntity: OptionEntity) {
        viewModel.selectedEntity = selectedEntity
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
