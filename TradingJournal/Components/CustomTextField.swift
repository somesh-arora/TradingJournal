//
//  CustomTextField.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/28/21.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var text: String
    
    private let headerText: String
    private let keyboardType: UIKeyboardType
    private let textInputAutocapitalization: TextInputAutocapitalization
    
    @State private var textFieldActive = false
    @State private var isTapped = false
    
    private var backgroundColor: Color {
        return textFieldActive ? .clear : Color.accentColor.opacity(0.08)
    }
    
    private var placeholderColor: Color {
        return textFieldActive ? Color.accentColor : .gray
    }
    
    private var shadowColor: Color {
        return textFieldActive ? Color.theme.accent.opacity(0.5) : .clear
    }
    
    private var borderColor: Color {
        return textFieldActive ? Color.theme.accent.opacity(0.5) : .clear
    }
    
    init(text: Binding<String>,
         headerText: String = "",
         keyboardType: UIKeyboardType = .default,
         textInputAutocapitalization: TextInputAutocapitalization = .words) {
        self._text = text
        self.headerText = headerText
        self.keyboardType = keyboardType
        self.textInputAutocapitalization = textInputAutocapitalization
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField("", text: $text) { status in
                // triggered when textField is clicked..
                textFieldActive = status
                if status {
                    withAnimation(.easeIn) {
                        isTapped = true
                    }
                } else {
                    if text.isEmpty {
                        withAnimation(.easeOut) {
                            isTapped = false
                        }
                    }
                }
            } onCommit: {
                // triggered when return button is tapped..
                textFieldActive = false
                if text.isEmpty {
                    withAnimation(.easeOut) {
                        isTapped = false
                    }
                }
            }
            .keyboardType(keyboardType)
            .textInputAutocapitalization(textInputAutocapitalization)
            .padding(.top, isTapped ? 15 : 0)
            .background(
                Text(headerText)
                    .font(.callout.bold())
                    .scaleEffect(isTapped ? 0.8 : 1.0)
                    .offset(x: isTapped ? -7 : 0, y: isTapped ? -15 : 0)
                    .foregroundColor(placeholderColor),
                alignment: .leading
            )
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(backgroundColor)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(borderColor, lineWidth: 2)
                .shadow(color: self.shadowColor, radius: 4, x: 0, y: 2)
        )
        .cornerRadius(8)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant("Placeholder"))
    }
}
