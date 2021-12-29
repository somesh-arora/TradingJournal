//
//  OptionDetailView.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/25/21.
//

import SwiftUI
import CoreData

struct OptionDetailLoadingView: View {
    
    @Binding var optionEntity: OptionEntity?
    
    var body: some View {
        ZStack {
            if let optionEntity = optionEntity {
                OptionDetailView(optionEntity: optionEntity)
            }
        }
    }
}

struct OptionDetailView: View {
    
    @StateObject private var viewModel: OptionDetailViewModel
    
    @State private var showActionSheet = false
    
    @Environment(\.presentationMode) var presentationMode
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let spacing: CGFloat = 10
   
    init(optionEntity: OptionEntity) {
        _viewModel = StateObject(wrappedValue: OptionDetailViewModel(optionEntity: optionEntity))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                titleView
                Divider()
                gridView
            }
            .padding()
        }
        .sheet(isPresented: $viewModel.showClosingTradeView) {
            CloseTradeView(viewModel: viewModel)
        }
        .navigationTitle(viewModel.optionEntity.ticker ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showActionSheet.toggle() }) {
                    Image(systemName: "ellipsis")
                }
                .confirmationDialog("Perform Action", isPresented: $showActionSheet, titleVisibility: .visible) {
                    Button("Edit") {
                        editTrade()
                    }
                    Button("Delete", role: .destructive) {
                        deleteTrade()
                    }
                    Button("Close Position") {
                        closeTrade()
                    }
                }
            }
        }
    }
    
    private var titleView: some View {
        Text("Your Position")
            .font(.title)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var gridView: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: []) {
            ForEach(viewModel.statistics) { stat in
                StatisticView(stat: stat)
            }
        }
    }
    
    private func deleteTrade() {

    }
    
    private func editTrade() {
        
    }
    
    private func closeTrade() {
        viewModel.showClosingTradeView.toggle()
    }
}

struct OptionDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            NavigationView {
                OptionDetailView(optionEntity: dev.openTrade)
                    .previewLayout(.sizeThatFits)
                    .environment(\.managedObjectContext, NSPersistentContainer(name: "OptionTrades").viewContext)
            }
            
            
            NavigationView {
                OptionDetailView(optionEntity: dev.openTrade)
                    .previewLayout(.sizeThatFits)
                    .preferredColorScheme(.dark)
                    .environment(\.managedObjectContext, NSPersistentContainer(name: "OptionTrades").viewContext)
            }
            
            NavigationView {
                OptionDetailView(optionEntity: dev.closedTrade)
                    .previewLayout(.sizeThatFits)
                    .environment(\.managedObjectContext, NSPersistentContainer(name: "OptionTrades").viewContext)
            }
            
            NavigationView {
                OptionDetailView(optionEntity: dev.closedTrade)
                    .previewLayout(.sizeThatFits)
                    .preferredColorScheme(.dark)
                    .environment(\.managedObjectContext, NSPersistentContainer(name: "OptionTrades").viewContext)
            }
        }
    }
}
