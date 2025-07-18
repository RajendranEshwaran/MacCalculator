//
//  ContentView.swift
//  MacCalculator
//
//  Created by Rajendran Eshwaran on 7/16/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var settings = CalculatorSettings()
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                switch settings.caluclatorMode {
                case .basic:BasicCalculatorView()
                case .scientific:SceintificCalculatorView()
                case .convertor:Text("Convertor View")
                case .engineering:Text("Engineering View")
                }
            }.edgesIgnoringSafeArea(.all)
        }.environmentObject(settings)
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

/*struct CalculatorTypeView: View {
    @EnvironmentObject var calculatorTypes: CalculatorSettings
    var body: some View {
        List(CalculatorTypes.allCases, id: \.self) { types in
            VStack {
                Text("\(types)")
                    .onTapGesture {
                        switch types {
                        case .basic:calculatorTypes.caluclatorMode
                        case .scientific: break
                        case .engineering:break
                            
                        case .convertor:break
                        @unknown default:
                            fatalError()
                        }
                    }
            }
        }.frame(width: 200, height: 220)
            .scrollDisabled(true)
            .scrollIndicators(.hidden)
    }
}*/
