//
//  AddPosition.swift
//  TradingJournal
//
//  Created by Somesh Arora on 1/1/22.
//

import Foundation
import UIKit
import SwiftUI

enum AddPosition: CaseIterable {
    case stockSymbol
    case strategy
    case optionPrice_open
//    case stockPrice_open
//    case collateral
    case contractCount
    case openDate
    case expirationDate
    
    var headerText: String {
        switch self {
        case .stockSymbol:
            return "Ticker"
        case .strategy:
            return "Strategy"
        case .optionPrice_open:
            return "Option Price"
//        case .stockPrice_open:
//            return "Stock Price"
//        case .collateral:
//            return "Collateral"
        case .contractCount:
            return "Contracts"
        case .openDate:
            return "Open Date"
        case .expirationDate:
            return "Expiration Date"
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .stockSymbol:
            return .alphabet
        case .strategy:
            return .alphabet
        case .optionPrice_open:
            return .decimalPad
//        case .stockPrice_open:
//            return .numbersAndPunctuation
//        case .collateral:
//            return .numbersAndPunctuation
        case .contractCount:
            return .numberPad
        default:
            return .default
        }
    }
    
    var autocapitalization: TextInputAutocapitalization {
        switch self {
        case .stockSymbol:
            return .characters
        case .strategy:
            return .words
//        case .collateral:
//            return .characters
        case .contractCount:
            return .characters
        default:
            return .words
        }
    }
    
    static func textField(for type: AddPosition, text: Binding<String>) -> some View {
        switch type {
        case .stockSymbol,
                .strategy,
                .optionPrice_open,
            //                .stockPrice_open,
            //                .collateral,
                .contractCount:
            return AnyView(
                CustomTextField(text: text,
                                headerText: type.headerText,
                                keyboardType: type.keyboardType,
                                textInputAutocapitalization: type.autocapitalization)
                    .id(type.headerText.lowercased())
                    .onTapGesture { }
            )
        default:
            return AnyView(EmptyView())
        }
    }
    
    static func datePicker(for type: AddPosition, date: Binding<Date>, dateAfter: Date? = nil) -> some View {
        switch type {
        case .openDate, .expirationDate:
            return AnyView(CustomDatePicker(date: date, headerText: type.headerText, dateAfter: dateAfter))
        default:
            return AnyView(EmptyView())
        }
    }
}
