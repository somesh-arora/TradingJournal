//
//  AddNewOptionView.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/25/21.
//

import SwiftUI

struct NewOptionModel: Identifiable {
    let id = UUID().uuidString
    let tickerSymbol: String
    let strategy: String
    let contractCount: Int
    let price: String
    let openDate: Date
    let expirationDate: Date
}

struct AddNewOptionView: View {
    @ObservedObject var viewModel: OptionTradeViewModel
    
    @State private var tickerSymbol: String = ""
    @State private var strategy: String = ""
    @State private var contractCount: Int = 1
    @State private var price: String = ""
    
    @State private var openDate: Date = Date()
    @State private var expirationDate: Date = Date()
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack {
            HStack {
                Text("New Position")
                    .font(.title)
                    .fontWeight(.heavy)
                
                Spacer(minLength: 0)
            }
            .padding()
            
            Form {
                Section {
                    HStack {
                        Text("Ticker")
                        Spacer()
                        TextField("Ex: AAPL", text: $tickerSymbol)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Strategy")
                        Spacer()
                        TextField("Ex: Iron Condor", text: $strategy)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Price")
                        Spacer()
                        TextField("Ex: 1.3", text: $price)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                    }
                    
                    HStack {
                        Stepper("Contracts: \(contractCount)", value: $contractCount, in: 1...9999)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section {
                    DatePicker(selection: $openDate, displayedComponents: .date) {
                        Text("Open Date")
                    }
                    
                    DatePicker(selection: $expirationDate, displayedComponents: .date) {
                        Text("Expiration Date")
                    }
                }
            }
            .padding()
            
            
            Button {
                let data = NewOptionModel(tickerSymbol: tickerSymbol, strategy: strategy, contractCount: contractCount, price: price, openDate: openDate, expirationDate: expirationDate)
                viewModel.addNewOptionTrade(data: data)
            } label: {
                Label {
                    Text("Add")
                        .font(.title2)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                } icon: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .padding(.vertical)
                .frame(width: UIScreen.main.bounds.width - 30)
                .background(
                    LinearGradient(gradient: .init(colors: [Color.theme.green.opacity(0.7), Color.theme.green, Color.theme.green.opacity(0.7)]), startPoint: .leading, endPoint: .trailing)
                )
                .cornerRadius(12)
            }
            .padding()
//            .disabled(homeViewModel.ticker.isEmpty)
//            .opacity(homeViewModel.ticker.isEmpty ? 0.5 : 1.0)
            
        }
    }
}

struct AddNewOptionView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewOptionView(viewModel: dev.optionTradeViewModel)
    }
}
