//
//  Calender.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/25/21.
//

import Foundation

extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> String {
        let fromDate = startOfDay(for: from) // <1>
        let toDate = startOfDay(for: to) // <2>
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>
        
        return "\(numberOfDays.day!)d"
    }
}
