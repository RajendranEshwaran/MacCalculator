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
                BasicCalculatorView()
               // CalculatorTypeView()
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    ContentView()
}

struct CalculatorDisplayView: View {
    @Binding var displayValue: String
    var body: some View {
        VStack {
            Text(displayValue)
                .font(.system(size: 50, weight: .light))
                .foregroundColor(.white)
                .padding(.leading)
                .frame(maxWidth: .infinity, maxHeight: 200, alignment: .trailing)
        }.background(Color.black)
    }
}

struct CalculatorTypeView: View {
    var body: some View {
        List(CalculatorTypes.allCases, id: \.self) { types in
            VStack {
                Text("\(types)")
            }
        }.frame(width: 200, height: 220)
            .scrollDisabled(true)
            .scrollIndicators(.hidden)
    }
}
