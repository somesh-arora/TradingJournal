//
//  AddNewOptionView.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/25/21.
//

import SwiftUI

struct NewOptionModel: Identifiable {
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
    @ObservedObject var viewModel: OptionTradeViewModel
    
    @State private var stockSymbol: String = ""
    @State private var strategy: String = ""
    @State private var optionPrice_open: String = ""
    @State private var stockPrice_open: String = ""
    @State private var collateral: String = ""
    @State private var contractCount: Int = 1
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
                        HStack(spacing: 4) {
                            attributeText("Ticker:")
//                            Image(systemName: "dollarsign.square")
                            TextField("Ex: MSFT, AAPL", text: $stockSymbol)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color.accentColor.opacity(0.08))
                        .cornerRadius(8)
                        
                    case .strategy:
                        HStack {
                            attributeText("Strategy:")
                            TextField("Ex: Iron Condor", text: $strategy)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color.accentColor.opacity(0.08))
                        .cornerRadius(8)
                    case .optionPrice_open:
                        HStack {
                            attributeText("Option Price:")
                            TextField("1.5", text: $optionPrice_open)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color.accentColor.opacity(0.08))
                        .cornerRadius(8)
                    case .stockPrice_open:
                        HStack {
                            attributeText("Stock Price:")
                            TextField("Ex: 200", text: $stockPrice_open)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color.accentColor.opacity(0.08))
                        .cornerRadius(8)
                    case .collateral:
                        HStack {
                            attributeText("Colletral:")
                            TextField("Ex: 1000", text: $collateral)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color.accentColor.opacity(0.08))
                        .cornerRadius(8)
                    case .contractCount:
                        HStack {
                            attributeText("Contracts:")
                            Stepper("\(contractCount)", value: $contractCount, in: 1...9999)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color.accentColor.opacity(0.08))
                        .cornerRadius(8)
                    case .openDate:
                        DatePicker(selection: $openDate, displayedComponents: .date) {
                            attributeText("Open Date:")
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color.accentColor.opacity(0.08))
                        .cornerRadius(8)
                    case .expirationDate:
                        DatePicker(selection: $expirationDate, displayedComponents: .date) {
                            attributeText("Expiration Date:")
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color.accentColor.opacity(0.08))
                        .cornerRadius(8)
                    }
                }
            }
        }
    }
    
    private func attributeText(_ text: String) -> some View {
        Text(text)
            .font(.callout.bold())
            .fontWeight(.heavy)
            .multilineTextAlignment(.trailing)
            .foregroundColor(Color.gray)
    }
    
    private var saveButtonView: some View {
        Button {
            let data = NewOptionModel(stockSymbol: stockSymbol,
                                      strategy: strategy,
                                      optionPrice_open: optionPrice_open,
                                      stockPrice_open: stockPrice_open,
                                      collateral: collateral,
                                      contractCount: contractCount,
                                      openDate: openDate,
                                      expirationDate: expirationDate)
            viewModel.addNewOptionTrade(data: data)
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
        AddNewOptionView(viewModel: dev.optionTradeViewModel)
    }
}
