//
//  MacCalculatorApp.swift
//  MacCalculator
//
//  Created by Rajendran Eshwaran on 7/16/25.
//

import SwiftUI

@main
struct MacCalculatorApp: App {
    @StateObject private var calculatorSettings = CalculatorSettings()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(calculatorSettings)
        }
    }
}
