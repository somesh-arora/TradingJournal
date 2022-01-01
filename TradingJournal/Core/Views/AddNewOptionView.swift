//
//  AddNewOptionView.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/25/21.
//

import SwiftUI

struct NewPositionModel: Identifiable {
    let id = UUID().uuidString
    let stockSymbol: String
    let strategy: String
    let optionPrice_open: String
    let stockPrice_open: String
    let collateral: String
    let contractCount: Int
    let openDate: Date
    let expirationDate: Date
}

enum NewTrade: CaseIterable {
    case stockSymbol
    case strategy
    case optionPrice_open
    case stockPrice_open
    case collateral
    case contractCount
    case openDate
    case expirationDate
}

struct AddNewOptionView: View {
    @EnvironmentObject private var viewModel: ManageOptionsViewModel
    
    @State private var stockSymbol: String = ""
    @State private var strategy: String = ""
    @State private var optionPrice_open: String = ""
    @State private var stockPrice_open: String = ""
    @State private var collateral: String = ""
    @State private var contractCount: Int = 0
    @State private var openDate: Date = Date()
    @State private var expirationDate: Date = Date()
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack(spacing: 20) {
            headerView
            formView
        }
        .padding()
        .navigationBarHidden(true)
        .navigationTitle("")
    }
    
    private var headerView: some View {
        HStack {
            LargeTitleView(title: "New Position")
            Spacer()
            saveButtonView
        }
    }
    
    private var formView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 12) {
                ForEach(NewTrade.allCases, id: \.self) { section in
                    switch section {
                    case .stockSymbol:
                        HStack(spacing: 10) {
                            titleView("Ticker:")
                            textField(placeholder: "Ex: MSFT, AAPL", text: $stockSymbol)
//                            Image(systemName: "dollarsign.square")
                        }
                    case .strategy:
                        HStack(spacing: 10) {
                            titleView("Strategy:")
                            textField(placeholder: "Ex: Iron Condor", text: $strategy)
                        }
                    case .optionPrice_open:
                        HStack(spacing: 10) {
                            titleView("Option Price:")
                            textField(placeholder: "1.5", text: $optionPrice_open)
                        }
                    case .stockPrice_open:
                        HStack(spacing: 10) {
                            titleView("Stock Price:")
                            textField(placeholder: "Ex: 200", text: $stockPrice_open)
                        }
                    case .collateral:
                        HStack(spacing: 10) {
                            titleView("Colletral:")
                            textField(placeholder: "Ex: 1000", text: $collateral)
                        }
                    case .contractCount:
                        HStack(spacing: 10) {
                            titleView("Contracts:")
                            Stepper(value: $contractCount, in: 0...9999) {
                                titleView("\(contractCount)")
                            }
                        }
                    case .openDate:
                        HStack(spacing: 10) {
                            DatePicker(selection: $openDate, displayedComponents: .date) {
                                titleView("Open Date:")
                            }
                        }
                    case .expirationDate:
                        HStack(spacing: 10) {
                            DatePicker(selection: $expirationDate, displayedComponents: .date) {
                                titleView("Expiration Date:")
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func titleView(_ text: String) -> some View {
        Text(text)
            .font(.callout.bold())
            .fontWeight(.heavy)
            .multilineTextAlignment(.trailing)
            .foregroundColor(Color.gray)
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color.accentColor.opacity(0.08))
            .cornerRadius(8)
    }
    
    private func textField(placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color.accentColor.opacity(0.08))
            .cornerRadius(8)
    }
    
    private var saveButtonView: some View {
        Button {
            let position = NewPositionModel(stockSymbol: stockSymbol,
                                      strategy: strategy,
                                      optionPrice_open: optionPrice_open,
                                      stockPrice_open: stockPrice_open,
                                      collateral: collateral,
                                      contractCount: contractCount,
                                      openDate: openDate,
                                      expirationDate: expirationDate)
            viewModel.addNewPosition(position)
        } label: {
            Text("Save")
                .padding(.horizontal, 12)
                .padding(.vertical, 5)
                .font(.callout.bold())
                .foregroundColor(.white)
                .background(
                    LinearGradient(gradient: .init(colors: [Color.blue.opacity(0.7), Color.blue, Color.blue.opacity(0.7)]), startPoint: .leading, endPoint: .trailing)
                )
                .cornerRadius(12)
        }
//            .disabled(homeViewModel.ticker.isEmpty)
//            .opacity(homeViewModel.ticker.isEmpty ? 0.5 : 1.0)
        
    }
}

struct AddNewOptionView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewOptionView()
    }
}
