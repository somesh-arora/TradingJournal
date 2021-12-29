//
//  LargeTitleView.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/28/21.
//

import SwiftUI

struct LargeTitleView: View {
    
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            Spacer(minLength: 0)
        }
    }
}

struct LargeTitleView_Previews: PreviewProvider {
    static var previews: some View {
        LargeTitleView(title: "Positions")
    }
}
