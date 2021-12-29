//
//  BackgroundModifier.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/28/21.
//

import Foundation
import SwiftUI

struct BackgroundModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.theme.background
                    .ignoresSafeArea()
            )
    }
}
