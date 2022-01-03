//
//  EmptyOptionsListView.swift
//  TradingJournal
//
//  Created by Somesh Arora on 1/2/22.
//

import SwiftUI

struct EmptyOptionsListView: View {
    
    @State private var animate: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("No positions yet! tap add button to get started")
                .font(.title)
                .fontWeight(.semibold)
            
            Text("Get started by adding your first trade to the list!")
                .font(.title3)
                .padding(.bottom)
            
            NavigationLink {
                AddPositionView()
            } label: {
                Text("Add")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.theme.newTrade)
                    .cornerRadius(10)
            }
            .padding(.horizontal, animate ? 30 : 50)
            .shadow(color: Color.theme.newTrade.opacity(0.7),
                    radius: animate ? 30 : 10,
                    x: 0,
                    y: animate ? 50 : 30)
            .scaleEffect(animate ? 1.1 : 1.0)
            .offset(y: animate ? -7 : 0)
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal, 30)
        .onAppear(perform: addAnimation)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}

struct EmptyOptionsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EmptyOptionsListView()
        }
    }
}
