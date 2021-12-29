//
//  CustomTextField.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/28/21.
//

import SwiftUI

struct CustomTextField: View {
    
    @StateObject var manager = CustomTextFieldManager()
    @State private var isTapped = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField("", text: $manager.text) { status in
                // triggered when textField is clicked..
                if status {
                    withAnimation(.easeIn) {
                        isTapped = true
                    }
                }
            } onCommit: {
                // triggered when return button is tapped..
                if manager.text.isEmpty {
                    withAnimation(.easeOut) {
                        isTapped = false
                    }
                }
            }
            .padding(.top, isTapped ? 15 : 0)
            .background(
                Text("Username")
                    .scaleEffect(isTapped ? 0.8 : 1.0)
                    .offset(x: isTapped ? -7 : 0, y: isTapped ? -15 : 0)
                    .foregroundColor(.gray),
                alignment: .leading
            )
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(5)
        
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField()
    }
}

class CustomTextFieldManager: ObservableObject {
    
    @Published var text = ""
}
