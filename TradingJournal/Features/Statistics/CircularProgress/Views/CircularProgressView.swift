//
//  CircularProgressView.swift
//  TradingJournal
//
//  Created by Somesh Arora on 12/28/21.
//

import SwiftUI

struct CircularProgressView: View {
    
    let model: CircularProgressModel
    
    let frame: CGFloat = (UIScreen.main.bounds.width) / 3
    
    var body: some View {
        VStack(spacing: 32) {
            headerView
            progressView
            if model.footer != nil {
                footerView
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.accentColor.opacity(0.05))
        .cornerRadius(16)
    }
    
    private var headerView: some View {
        VStack(alignment: .center, spacing: 6) {
            Text(model.header)
                .font(.system(size: 18))
                .fontWeight(.bold)
            
            Text(model.subheader)
                .font(.footnote)
                .foregroundColor(Color.theme.secondary)
        }
    }
    
    private var progressView: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 1)
                .stroke(model.progressColor.opacity(0.05), lineWidth: 10)
                .frame(width: frame, height: frame)
            
            Circle()
                .trim(from: 0, to: (model.currentValue / model.targetValue))
                .stroke(model.progressColor, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .frame(width: frame, height: frame)
            
            Text(getPercentageValue(currentValue: model.currentValue, targetValue: model.targetValue) + " %")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundColor(model.progressColor)
                .rotationEffect(.init(degrees: 90))
        }
        .rotationEffect(.init(degrees: -90))
        .shadow(color: model.progressColor.opacity(0.25), radius: 10, x: 0, y: 0)
    }
    
    private var footerView: some View {
        Text(model.footer ?? "")
            .font(.footnote.bold())
            .foregroundColor(Color.theme.secondary)
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(model: dev.circularProgressModel)
    }
}

extension CircularProgressView {
    private func getPercentageValue(currentValue: CGFloat, targetValue: CGFloat) -> String {
        return String(format: "%0.1f", (currentValue / targetValue) * 100)
    }
}
