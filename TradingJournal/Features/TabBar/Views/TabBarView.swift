//
//  TabBarView.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/28/21.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var currentTab: TabBarItems = .home
    
    @EnvironmentObject private var viewModel: ManageOptionsViewModel
    
    @State private var showNewTradeForm = false
    
    var body: some View {
        VStack(spacing: 0) {
            tabView
            tabBarItems
        }
    }
    
    private var tabView: some View {
        TabView(selection: $currentTab) {
            ForEach(TabBarItems.allCases, id: \.self) { item in
                item.view
            }
        }
    }
    
    private var tabBarItems: some View {
        HStack(spacing: 40) {
            ForEach(TabBarItems.allCases, id: \.self) { item in
                if item == .newTrade {
                    newTradeButton(item: item)
                } else {
                    tabButton(item: item)
                }
            }
        }
        .padding(.top, -10)
        .frame(maxWidth: .infinity)
        .background(
            Color.theme.background
                .ignoresSafeArea()
        )
    }
    
    private func tabButton(item: TabBarItems) -> some View {
        Button {
            withAnimation {
                currentTab = item
            }
        } label: {
            Image(systemName: item.imageName)
                .frame(width: 30, height: 30)
                .foregroundColor(currentTab == item ? Color.theme.accent : Color.theme.accent.opacity(0.8))
        }
    }
    
    private func newTradeButton(item: TabBarItems) -> some View {
        Button {
            withAnimation {
                showNewTradeForm.toggle()
            }
        } label: {
            Image(systemName: item.imageName)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
                .padding(22)
                .background(
                    Circle()
                        .fill(Color.theme.newTrade)
                        .shadow(color: Color.theme.newTrade.opacity(0.15), radius: 5, x: 0, y: 8)
                )
        }
//        .popover(isPresented: $showNewTradeForm, content: AddPositionView.init)
        .fullScreenCover(isPresented: $showNewTradeForm,
                         content: AddPositionView.init)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
