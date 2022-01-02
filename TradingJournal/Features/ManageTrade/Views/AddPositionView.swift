//
//  AddPositionView.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/25/21.
//

import SwiftUI

struct NewPositionModel: Identifiable {
    let id = UUID()
    let stockSymbol: String
    let strategy: String
    let optionPrice_open: String
//    let stockPrice_open: String
//    let collateral: String
    let contractCount: String
    let openDate: Date
    let expirationDate: Date
}

struct AddPositionView: View {
    @EnvironmentObject private var viewModel: ManageOptionsViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var stockSymbol: String = ""
    @State private var strategy: String = ""
    @State private var optionPrice_open: String = ""
//    @State private var stockPrice_open: String = ""
//    @State private var collateral: String = ""
    @State private var contractCount: String = ""
    @State private var openDate: Date = Date()
    @State private var expirationDate: Date = Date()
    
    var body: some View {
        VStack(spacing: 20) {
            headerView
            formView
            addButtonView
        }
        .padding()
        .navigationBarHidden(true)
        .navigationTitle("")
        .modifier(BackgroundModifier())
        .ignoresSafeArea(.keyboard)
    }
    
    private var headerView: some View {
        HStack {
            Spacer()
            Text("New Position")
                .font(.title)
                .fontWeight(.heavy)
            Spacer()
        }
        .background(
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.down")
                    .font(.title3.bold())
                    .foregroundColor(Color.primary)
            })
            , alignment: .leading
        )
    }
    
    private var formView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 12) {
                sections
            }
        }
    }
    
    private var sections: some View {
        ForEach(AddPosition.allCases, id: \.self) { section in
            switch section {
            case .stockSymbol:
                AddPosition.textField(for: section, text: $stockSymbol)
            case .strategy:
                strategySection
            case .optionPrice_open:
                AddPosition.textField(for: section, text: $optionPrice_open)
                //            case .stockPrice_open:
                //                AddPosition.textField(for: section, text: $stockPrice_open)
                //            case .collateral:
                //                AddPosition.textField(for: section, text: $collateral)
            case .contractCount:
                AddPosition.textField(for: section, text: $contractCount)
            case .openDate:
                AddPosition.datePicker(for: section, date: $openDate)
            case .expirationDate:
                AddPosition.datePicker(for: section, date: $expirationDate, dateAfter: openDate)
            }
        }
    }
    
    private var addButtonView: some View {
        Button {
            addAction()
        } label: {
            addButtonLabel
        }
        //            .disabled(homeViewModel.ticker.isEmpty)
        //            .opacity(homeViewModel.ticker.isEmpty ? 0.5 : 1.0)
    }
    
    private var addButtonLabel: some View {
        Text("Add")
            .padding()
            .font(.title3.bold())
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(gradient: .init(colors: [Color.blue.opacity(0.7), Color.blue, Color.blue.opacity(0.7)]), startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(12)
    }
    
    private func addAction() {
        let position = NewPositionModel(stockSymbol: stockSymbol,
                                  strategy: strategy,
                                  optionPrice_open: optionPrice_open,
//                                      stockPrice_open: stockPrice_open,
//                                      collateral: collateral,
                                  contractCount: contractCount,
                                  openDate: openDate,
                                  expirationDate: expirationDate)
        viewModel.addNewPosition(position)
        presentationMode.wrappedValue.dismiss()
    }
    
    private var strategySection: some View {
        Menu {
            ForEach(OptionStrategies.allCases, id: \.self) { strategy in
                Button {
                    withAnimation(.none) {
                        self.strategy = strategy.rawValue
                    }
                } label: {
                    Text(strategy.rawValue)
                }
            }
        } label: {
            AddPosition.textLabel(for: AddPosition.strategy, text: $strategy)
        }
    }
}

struct AddNewOptionView_Previews: PreviewProvider {
    static var previews: some View {
        AddPositionView()
    }
}
