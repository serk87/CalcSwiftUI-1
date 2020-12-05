//
//  GlobalEnvironment.swift
//  CalcSwiftUI-1
//
//  Created by ladmin on 05.12.2020.
//

import Foundation
import SwiftUI
import MathKit

class GlobalEnvironment: ObservableObject {
    
    @Published var display = "0"
    private var firstNumber = 0
    private var secondNumber = 0
    private var action = ""
    
    let system = System()
    
    func receiveInput(calculatorButton: CalculatorButton) {
        switch calculatorButton {
        case .ac:
            display = "0"
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .plus, .divide, .multiply, .minus:
            if display != "0" {
                self.display += calculatorButton.title
            } else {
                self.display = calculatorButton.title
            }
        case .decimal:
            self.display += calculatorButton.title
        case .plusMinus:
            let plusMinusAction  = "-(\(self.display))"
            let result = try! Expression(string: plusMinusAction, system: system).evaluate()
            self.display = String(describing: result)
        case .percent:
            let plusMinusAction  = "(\(self.display))/100"
            let result = try! Expression(string: plusMinusAction, system: system).evaluate()
            self.display = String(describing: result)
        case .equals:
            let result = try! Expression(string: display, system: system).evaluate()
            self.display = String(describing: result)
            
        default:
            break
        }
        
    }
    
}
