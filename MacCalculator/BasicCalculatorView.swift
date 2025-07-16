//
//  BasicCalculatorView.swift
//  MacCalculator
//
//  Created by Rajendran Eshwaran on 7/16/25.
//

import SwiftUI

struct BasicCalculatorView: View {
    var body: some View {
        VStack {
            Spacer()
            CalculatorKeyboardView(row: 5, columns: 4, calculatorButtonTitles: basicCalculatorButtonTitles) { x,y  in
                VStack {
                    Button(action: { }) {
                        let test = basicCalculatorButtonTitles[x][y]
                        Text("\(test)")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 80, height: 80)
                            .background(buttonColor(button: test))
                    }.clipShape(.circle)
                    
                }
            }
            Spacer()
        }
    }
}

#Preview {
    BasicCalculatorView()
}
