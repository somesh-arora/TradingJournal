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
    let contractCount: String
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
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var stockSymbol: String = ""
    @State private var strategy: String = ""
    @State private var optionPrice_open: String = ""
    @State private var stockPrice_open: String = ""
    @State private var collateral: String = ""
    @State private var contractCount: String = ""
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
        .modifier(BackgroundModifier())
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
                        CustomTextField(text: $stockSymbol,
                                        headerText: "Ticker",
                                        keyboardType: .alphabet,
                                        textInputAutocapitalization: .characters)
                    case .strategy:
                        CustomTextField(text: $strategy,
                                        headerText: "Strategy",
                                        keyboardType: .alphabet,
                                        textInputAutocapitalization: .words)
                    case .optionPrice_open:
                        CustomTextField(text: $optionPrice_open,
                                        headerText: "Option Price",
                                        keyboardType: .decimalPad)
                    case .stockPrice_open:
                        CustomTextField(text: $stockPrice_open,
                                        headerText: "Stock Price",
                                        keyboardType: .numbersAndPunctuation)
                    case .collateral:
                        CustomTextField(text: $collateral,
                                        headerText: "Colletral",
                                        keyboardType: .numbersAndPunctuation,
                                        textInputAutocapitalization: .characters)
                    case .contractCount:
                        CustomTextField(text: $contractCount,
                                        headerText: "Contracts",
                                        keyboardType: .numberPad,
                                        textInputAutocapitalization: .characters)
                    case .openDate:
                        CustomDatePicker(date: $openDate,
                                         headerText: "Open Date")
                    case .expirationDate:
                        CustomDatePicker(date: $expirationDate,
                                         headerText: "Expiration Date",
                                         dateAfter: openDate)
                    }
                }
            }
        }
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
            presentationMode.wrappedValue.dismiss()
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
