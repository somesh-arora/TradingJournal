//
//  ClosePosition.swift
//  TradingJournal
//
//  Created by Somesh Arora on 1/1/22.
//

import Foundation
import SwiftUI

enum ClosePosition: CaseIterable {
    case optionPrice_close
//    case stockPrice_close
    case closeDate
    
    var headerText: String {
        switch self {
        case .optionPrice_close:
            return "Option Price"
//        case .stockPrice_close:
//            return "Stock Price"
        case .closeDate:
            return "Close Date"
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .optionPrice_close:
            return .decimalPad
//        case .stockPrice_close:
//            return .numbersAndPunctuation
        case .closeDate:
            return .default
        }
    }
    
    var autocapitalization: TextInputAutocapitalization {
        return .words
    }
    
    static func textField(for type: ClosePosition, text: Binding<String>) -> some View {
        switch type {
        case .optionPrice_close:
            return AnyView(CustomTextField(text: text,
                                           headerText: type.headerText,
                                           keyboardType: type.keyboardType,
                                           textInputAutocapitalization: type.autocapitalization))
        default:
            return AnyView(EmptyView())
        }
    }
    
    static func datePicker(for type: ClosePosition, date: Binding<Date>, dateAfter: Date? = nil) -> some View {
        switch type {
        case .closeDate:
            return AnyView(CustomDatePicker(date: date, headerText: type.headerText, dateAfter: dateAfter))
        default:
            return AnyView(EmptyView())
        }
    }
}
