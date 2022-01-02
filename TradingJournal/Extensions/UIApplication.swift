//
//  UIApplication.swift
//  TradingJournal
//
//  Created by Somesh Arora on 1/1/22.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
