//
//  CircularProgressGridView.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/28/21.
//

import SwiftUI

struct CircularProgressGridView: View {
    
    let data: [CircularProgressModel]
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
            ForEach(data) { value in
                CircularProgressView(model: value)
            }
        }
    }
}

struct CircularProgressGridView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressGridView(data: [dev.circularProgressModel, dev.circularProgressModel, dev.circularProgressModel])
    }
}
