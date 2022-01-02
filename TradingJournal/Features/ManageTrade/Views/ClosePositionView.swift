//
//  ClosePositionView.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/26/21.
//

import SwiftUI

struct ClosePositionModel {
    let optionPrice_close: String
//    let stockPrice_close: String
    let closeDate: Date
}

struct ClosePositionView: View {
    
    @EnvironmentObject private var viewModel: ManageOptionsViewModel
    
    @Binding var optionEntity: OptionEntity
    
    @Binding var showCloseTradeForm: Bool
    
    @State private var optionPrice_close: String = ""
//    @State private var stockPrice_close: String = ""
    @State private var closeDate: Date = Date()
    
    var body: some View {
        VStack(spacing: 20) {
            headerView
            formView
            closeButtonView
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
            Text("Close Position")
                .font(.title)
                .fontWeight(.heavy)
            Spacer()
        }
        .background(
            Button(action: {
                showCloseTradeForm.toggle()
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
        ForEach(ClosePosition.allCases, id: \.self) { section in
            switch section {
            case .optionPrice_close:
                ClosePosition.textField(for: section, text: $optionPrice_close)
//            case .stockPrice_close:
//                ClosePosition.textField(for: section, text: $stockPrice_close)
            case .closeDate:
                ClosePosition.datePicker(for: section, date: $closeDate)
            }
        }
    }
    
    private var closeButtonView: some View {
        Button {
            closeAction()
        } label: {
            closeButtonLabel
        }
        //            .disabled(homeViewModel.ticker.isEmpty)
        //            .opacity(homeViewModel.ticker.isEmpty ? 0.5 : 1.0)
    }
    
    private var closeButtonLabel: some View {
        Text("Close")
            .padding()
            .font(.callout.bold())
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(gradient: .init(colors: [Color.blue.opacity(0.7), Color.blue, Color.blue.opacity(0.7)]), startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(12)
    }
    
    private func closeAction() {
        let data = ClosePositionModel(optionPrice_close: optionPrice_close,
//                                          stockPrice_close: stockPrice_close,
                                      closeDate: closeDate)
        viewModel.closePosition(optionEntity, data: data)
        showCloseTradeForm.toggle()
    }
}

struct CloseTradeView_Previews: PreviewProvider {
    static var previews: some View {
        ClosePositionView(optionEntity: .constant(dev.closedTrade), showCloseTradeForm: .constant(true))
    }
}
