//
//  OptionDetailView.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/25/21.
//

import SwiftUI
import CoreData

struct OptionDetailLoadingView: View {
    @EnvironmentObject private var viewModel: ManageOptionsViewModel
    
    var body: some View {
        ZStack {
            if let optionEntity = viewModel.selectedEntity {
                OptionDetailView(optionEntity: optionEntity)
                    .modifier(BackgroundModifier())
            }
        }
    }
}

struct OptionDetailView: View {
    @StateObject private var viewModel: OptionDetailViewModel
    
    @State private var showCloseTradeForm = false
    
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
        .fullScreenCover(isPresented: $showCloseTradeForm) {
            ClosePositionView(optionEntity: $viewModel.optionEntity, showCloseTradeForm: $showCloseTradeForm)
        }
        .navigationTitle(viewModel.optionEntity.stockSymbol ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                tradeActionView
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
                StatsView(stat: stat)
            }
        }
    }
    
    private var tradeActionView: some View {
        Menu {
            if viewModel.optionEntity.isOpen {
                Button {
                    closeAction()
                } label: {
                    Label("Close", systemImage: "xmark")
                }
            }
            
            Button {
                editAction()
            } label: {
                Label("Edit", systemImage: "pencil")
            }

            Button(role: .destructive) {
                deleteAction()
            } label: {
                Label("Delete", systemImage: "trash.fill")
            }

        } label: {
            Image(systemName: "ellipsis")
                .frame(width: 18, height: 18)
                .foregroundColor(.primary)
        }
    }
    
    private func deleteAction() {
        // TODO
    }
    
    private func editAction() {
        // TODO
    }
    
    private func closeAction() {
        showCloseTradeForm.toggle()
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
