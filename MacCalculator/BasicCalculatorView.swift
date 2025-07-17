//
//  BasicCalculatorView.swift
//  MacCalculator
//
//  Created by Rajendran Eshwaran on 7/16/25.
//

import SwiftUI

struct BasicCalculatorView: View {
    @State private var displayValue: String = "0"
    @State private var types: Bool = false
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
                                types.toggle()
                            } else {
                                let result = buttonOperationTapped(basicCalculatorButtonTitles[x][y], displayValue: &displayValue)
                                displayValue = String(result.1)
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
        }
    }
}

#Preview {
    BasicCalculatorView()
}
