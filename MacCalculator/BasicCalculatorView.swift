//
//  BasicCalculatorView.swift
//  MacCalculator
//
//  Created by Rajendran Eshwaran on 7/16/25.
//

import SwiftUI

struct BasicCalculatorView: View {
    @State private var displayValue: String = "0"
    @State private var calculatorTypes: Bool = false
    @State private var storedValue: String? = ""
    @State private var storedOperation: String? = nil
    @StateObject var settings = CalculatorSettings()
    var body: some View {
        ZStack {
            VStack {
                CalculatorDisplayView(displayValue: $displayValue)
                    .padding(.top, 50)
                Spacer()
                CalculatorKeyboardView(row: 5, columns: 4, calculatorButtonTitles: basicCalculatorButtonTitles) { x,y  in
                    VStack {
                        Button(action: {
                            let buttons = basicCalculatorButtonTitles[x][y]
                            if buttons == "TY" {
                                calculatorTypes.toggle()
                            } else {
                                let result = buttonOperationTapped(basicCalculatorButtonTitles[x][y], displayValue: &displayValue, storedValue: &storedValue, previousOperation: &storedOperation)
                            
                                displayValue = String(result.0)
                                storedValue = String(result.1 ?? "")
                                storedOperation = String(result.2 ?? "")
                            }
                        }) {
                            let buttons = basicCalculatorButtonTitles[x][y]
                            Text("\(buttons)")
                                .font(.system(size: 25, weight: .bold))
                                .foregroundStyle(buttonTextColor(button: buttons))
                                .frame(width: 80, height: 80)
                                .background(buttonColor(button: buttons))
                        }.clipShape(.circle)
                    }
                }
                Spacer()
            }
            if calculatorTypes {
                List(CalculatorTypes.allCases, id: \.self) { types in
                    VStack {
                        Text("\(types)")
                            .onTapGesture {
                                switch types {
                                case .basic:
                                    calculatorTypes = false
                                    settings.caluclatorMode = .basic
                                case .scientific:
                                    calculatorTypes = false
                                    settings.caluclatorMode = .scientific
                                case .engineering:
                                    calculatorTypes = false
                                    settings.caluclatorMode = .engineering
                                case .convertor:
                                    calculatorTypes = false
                                    settings.caluclatorMode = .convertor
                                @unknown default:
                                    fatalError()
                                }
                            }
                    }
                }.frame(width: 200, height: 200)
                .scrollDisabled(true)
                .scrollIndicators(.hidden)
                .offset(y: 300)
            }
        }.environmentObject(settings)
    }
}

#Preview {
    BasicCalculatorView()
}
