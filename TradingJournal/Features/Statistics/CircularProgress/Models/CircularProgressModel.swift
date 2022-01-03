//
//  CircularProgressModel.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/28/21.
//

import Foundation
import SwiftUI

struct CircularProgressModel: Identifiable {
    let id = UUID().uuidString
    let header: String
    let subheader: String
    let currentValue: CGFloat
    let targetValue: CGFloat
    let progressColor: Color
    let footer: String?
}
