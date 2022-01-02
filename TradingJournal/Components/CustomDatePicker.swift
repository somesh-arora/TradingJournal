//
//  CustomDatePicker.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/31/21.
//

import SwiftUI

struct CustomDatePicker: View {
    
    @Binding var date: Date
    private let headerText: String
    private let dateAfter: Date?
    
    init(date: Binding<Date>,
         headerText: String,
         dateAfter: Date? = nil) {
        self._date = date
        self.headerText = headerText
        self.dateAfter = dateAfter
    }
    
    var body: some View {
        datePicker
            .padding(.horizontal)
            .padding(.vertical, 5)
            .background(Color.accentColor.opacity(0.08))
            .cornerRadius(8)
    }
    
    @ViewBuilder
    private var datePicker: some View {
        if let dateAfter = dateAfter {
            DatePicker(selection: $date,
                       in: dateAfter...,
                       displayedComponents: .date) {
                label(headerText)
            }
        } else {
            DatePicker(selection: $date,
                       displayedComponents: .date) {
                label(headerText)
            }
        }
    }
    
    private func label(_ text: String) -> some View {
        Text(text)
            .font(.callout.bold())
            .multilineTextAlignment(.trailing)
            .foregroundColor(Color.gray)
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        CustomDatePicker(date: .constant(Date()), headerText: "Date")
    }
}
