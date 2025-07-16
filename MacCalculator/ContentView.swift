//
//  ContentView.swift
//  MacCalculator
//
//  Created by Rajendran Eshwaran on 7/16/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                CalculatorDisplayView()
                    .padding(.top, 50)
                Spacer()
                BasicCalculatorView()
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    ContentView()
}

struct CalculatorDisplayView: View {
    var body: some View {
        VStack {
            Text("000000")
                .font(.system(size: 50, weight: .light))
                .foregroundColor(.white)
                .padding(.leading)
                .frame(maxWidth: .infinity, maxHeight: 200, alignment: .trailing)
        }.background(Color.gray)
    }
}
