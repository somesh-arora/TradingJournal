//
//  CustomTextLabel.swift
//  TradingJournal
//
//  Created by Somesh Arora on 1/1/22.
//

import SwiftUI

struct CustomTextLabel: View {
    
    @Binding var text: String
    private let headerText: String
    
    init(text: Binding<String>,
         headerText: String) {
        self._text = text
        self.headerText = headerText
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(text)
                    .foregroundColor(Color.primary)
                Spacer()
            }
            .padding(.top, text.isEmpty ? 0 : 15)
            .padding(.vertical, text.isEmpty ? 5 : 0)
            .background(
                Text(headerText)
                    .font(.callout.bold())
                    .foregroundColor(.gray)
                    .scaleEffect(text.isEmpty ? 1.0 : 0.8)
                    .offset(x: text.isEmpty ? 0 : -7, y: text.isEmpty ? 0 : -15),
                alignment: .leading
            )
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(Color.accentColor.opacity(0.08))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.clear, lineWidth: 2)
                .shadow(color: .clear, radius: 4, x: 0, y: 2)
        )
        .cornerRadius(8)
    }
}

struct CustomTextLabel_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextLabel(text: .constant(OptionStrategies.callCreditSpread.rawValue),
                        headerText: "Strategies")
    }
}
