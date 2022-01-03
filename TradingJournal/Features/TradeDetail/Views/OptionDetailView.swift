//
//  OptionDetailView.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/25/21.
//

import SwiftUI
import CoreData

struct OptionDetailView: View {
    
    @EnvironmentObject private var viewModel: ManageOptionsViewModel
    
    let optionDetailViewModel = OptionDetailViewModel()
    
    @State private var showCloseTradeForm = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                titleView
                Divider()
                statisticsView
            }
            .padding()
        }
        .modifier(BackgroundModifier())
        .fullScreenCover(isPresented: $showCloseTradeForm) {
            ClosePositionView(showCloseTradeForm: $showCloseTradeForm)
        }
        .navigationTitle(viewModel.selectedEntity?.stockSymbol ?? "")
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
    
    private var statisticsView: some View {
        StatsGridView(stats: optionDetailViewModel.getStatisticArray(entity: viewModel.selectedEntity))
    }
    
    private var tradeActionView: some View {
        Menu {
            if viewModel.selectedEntity?.isOpen ?? false {
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
                OptionDetailView()
                    .previewLayout(.sizeThatFits)
                    .environment(\.managedObjectContext, NSPersistentContainer(name: "OptionTrades").viewContext)
            }
            
            
            NavigationView {
                OptionDetailView()
                    .previewLayout(.sizeThatFits)
                    .preferredColorScheme(.dark)
                    .environment(\.managedObjectContext, NSPersistentContainer(name: "OptionTrades").viewContext)
            }
            
            NavigationView {
                OptionDetailView()
                    .previewLayout(.sizeThatFits)
                    .environment(\.managedObjectContext, NSPersistentContainer(name: "OptionTrades").viewContext)
            }
            
            NavigationView {
                OptionDetailView()
                    .previewLayout(.sizeThatFits)
                    .preferredColorScheme(.dark)
                    .environment(\.managedObjectContext, NSPersistentContainer(name: "OptionTrades").viewContext)
            }
        }
    }
}
