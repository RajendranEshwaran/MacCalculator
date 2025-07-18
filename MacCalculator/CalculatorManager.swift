//
//  CalculatorManager.swift
//  MacCalculator
//
//  Created by Rajendran Eshwaran on 7/16/25.
//

import Foundation
import SwiftUI

class CalculatorSettings: ObservableObject {
    @Published var caluclatorMode: CalculatorTypes = .basic
}

enum CalculatorTypes: String, CaseIterable {
    case basic = "Basic"
    case scientific = "Scientific"
    case engineering = "Engineering"
    case convertor = "Convertor"
}

enum CalculatorError: Error {
    case invalidCalculatorType
}

enum CalculatorOperation: String, CaseIterable {
    case add = "+"
    case subtract = "-"
    case multiply = "*"
    case divide = "/"
    case power = "^"
    case root = "√"
    case percent = "%"
    case clear = "C"
    case backspace = "⌫"
}

let basicCalculatorButtonTitles: [[String]] = [
["AC", "⁺∕₋", "%", "÷"],
["7", "8", "9", "x"],
["4", "5", "6", "-"],
["1", "2", "3", "+"],
["TY", "0", ".", "="]]

let scientificCalculatorButtonTitles: [[String]] = [
    ["(", ")", "mc", "m+", "m-", "mr", "⌫", "⁺∕₋", "%", "÷"],
    ["2nd", "x²", "x³", "x^y", "e^x", "10^x", "7", "8", "9", "x"],
    ["1∕x", "²√×", "³√×", "γ√×", "In", "log10","4", "5", "6", "-"],
    ["x!", "sin", "cos", "tan", "e", "EE", "1", "2", "3", "+"],
    ["TY", "sinh", "cosh", "tanh", "π", "Rad", "Rand", "0", ".", "="]]

let engineeringCalculatorButtonTitles: [[String]] = [
     ["(", ")", "XOR", "D", "E", "F", "⌫"],
     ["AND", "OR", "NOR", "A", "B", "C", "÷"],
     ["NOT", "<<", ">>", "7", "8", "9","x"],
     ["NEG", "X<<Y", "X>>Y", "4", "5", "6", "-"],
     ["mod", "RoL", "RoR", "1", "2", "3", "+"],
     ["TY", "flip8", "flip16", "FF", "0", "00", "="]]

let convertorCalculatorButtonTitles: [[String]] = [
    ["°C to °F"],
    ["°F to °C"],
    ["°C to K"],
    ["K to °C"],
    ["°F to K"],
    ["K to °F"],
    ["Metric to Imperial"],
    ["TY", "Imperial to Metric"]]


// U+1F5A9


struct CalculatorKeyboardView<Content: View>: View {
    private let row: Int
    private let columns: Int
    private let content: (Int, Int) -> Content
    private let calculatorButtonTitles: [[String]]
    
    init(row: Int, columns: Int, calculatorButtonTitles: [[String]], @ViewBuilder  content: @escaping (Int, Int) -> Content) {
        self.row = row
        self.columns = columns
        self.calculatorButtonTitles = calculatorButtonTitles
        self.content = content
    }
    
    private func nthPosition(_ x: Int, _ y: Int) -> Int {
        (columns * y) + x
      }
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(0..<row, id: \.self) { y in
                HStack(spacing: 10) {
                    ForEach(0..<columns, id: \.self) { x in
                        //content(nthPosition(x, y), x)
                        content(y, x)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }
}

func buttonColor(button: String) -> Color {
    switch button {
    case "=", "+", "-", "÷", "x": return Color.orange
    case "AC", "⁺∕₋", "⌫", "%": return Color.gray.opacity(0.5)
    default: return Color.gray.opacity(1.0)
    }
}

func buttonTextColor(button: String) -> Color {
    switch button {
    default: return Color.white
    }
}

// return params -> displayvalue, previousvalue, previousoperation
func buttonOperationTapped(_ operation: String, displayValue: inout String, storedValue: inout String?, previousOperation: inout String?) -> (String, String?, String?) {
    var previousValue: String? = storedValue
    var previousOperation: String? = previousOperation
    var result: Double = 0.0
    switch operation {
    case "+", "-", "x", "÷":
        previousOperation = operation
        previousValue = displayValue
        return (displayValue, previousValue, previousOperation)
    case "AC":
        displayValue = "0"
        previousValue = displayValue
        previousOperation = nil
        return (displayValue, "", "")
    case "=":
       if let currentOperation = previousOperation, let storedValue = previousValue, let currentValue =  Double (displayValue) {
           switch currentOperation {
           case "+":
               result = (Double(storedValue) ?? 0.0) + Double(currentValue)
           case "-":
               result = (Double(storedValue) ?? 0.0) - Double(currentValue)
           case "x":
               result = (Double(storedValue) ?? 0.0) * Double(currentValue)
           case "÷":
               result = (Double(storedValue) ?? 0.0) / Double(currentValue)
           default: break
           }
        }
        return (String(result), previousValue, previousOperation)
    case "TY":
        return ("", "" ,"")
    case "0"..."9", ".":
        if displayValue == "0" && operation != "." {
            displayValue = operation
        } else if previousOperation == nil || previousOperation?.isEmpty ?? true {
            displayValue += operation
        } else {
            displayValue = operation
        }
        return (displayValue, previousValue, previousOperation)
    default:
        return (displayValue, previousValue, previousOperation)
    }
}
