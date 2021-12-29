//
//  CloseTradeView.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/26/21.
//

import SwiftUI

struct CloseOptionTradeModel {
    let closingPrice: String
    let closingDate: Date
    let stockPriceAtClosing: String
    let notes: String?
}

struct CloseTradeView: View {
    
    @ObservedObject var viewModel: OptionDetailViewModel
    
    @State private var closingPrice: String = ""
    @State private var stockPriceAtClosing: String = ""
    @State private var notes: String? = nil
    @State private var closingDate: Date = Date()
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack {
            HStack {
                Text("Close Position")
                    .font(.title)
                    .fontWeight(.heavy)
                
                Spacer(minLength: 0)
            }
            .padding()
            
            Form {
                Section {
                    HStack {
                        Text("Closing Price")
                        Spacer()
                        TextField("Ex: 0.00", text: $closingPrice)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Stock Price")
                        Spacer()
                        TextField("Ex: 200", text: $stockPriceAtClosing)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                    }
                }
                
                Section {
                    DatePicker(selection: $closingDate, displayedComponents: .date) {
                        Text("Closing Date")
                    }
                }
            }
            
            Button {
                let data = CloseOptionTradeModel(closingPrice: closingPrice, closingDate: closingDate, stockPriceAtClosing: stockPriceAtClosing, notes: nil)
                viewModel.closeOptionTrade(data: data)
            } label: {
                Label {
                    Text("Close Trade")
                        .font(.title2)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                } icon: {
                    Image(systemName: "checkmark.seal")
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
        }
    }
}

struct CloseTradeView_Previews: PreviewProvider {
    static var previews: some View {
        CloseTradeView(viewModel: dev.optionDetailViewModel)
    }
}
