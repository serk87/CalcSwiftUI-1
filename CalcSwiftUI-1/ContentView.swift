//
//  ContentView.swift
//  CalcSwiftUI-1
//
//  Created by ladmin on 05.12.2020.
//

import SwiftUI

enum CalculatorButton: String {
    
    case zero, one, two, three, four, five, six, seven, eight, nine
    case equals, plus, minus, multiply, divide
    case decimal
    case ac, plusMinus, percent
    
    var title: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "*"
        case .divide: return "/"
        case .plusMinus: return "*(-1)"
        case .percent: return "%"
        case .equals: return "="
        case .decimal: return "."
        default:
            return "AC"
        }
    }
    
    var icon: String {
        switch self {
        case .multiply: return "multiply"
        case .divide: return "divide"
        case .plusMinus: return "plusminus"
        case .equals: return "equal"
        case .plus: return "plus"
        case .minus: return "minus"
        case .percent: return "percent"
        default:
            return ""
        }
    }
    var backgroundColor: Color {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal:
            return Color(.darkGray)
        case .ac, .plusMinus, .percent:
            return Color(.lightGray)
        default:
            return .orange
        }
    }
}




struct ContentView: View {
    
    
    @EnvironmentObject var env: GlobalEnvironment
    
    let buttons: [String: [CalculatorButton]] = [
        "1": [.ac, .plusMinus, .percent, .divide],
        "2": [.seven, .eight, .nine, .multiply],
        "3":  [.four, .five, .six, .minus],
        "4": [.one, .two, .three, .plus],
        "5": [.zero, .decimal, .equals]
    ]
    
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(spacing: 12) {
                
                HStack {
                    Spacer()
                    Text(env.display).foregroundColor(.white)
                        .font(.system(size: 64))
                }.padding()
                ForEach(buttons.keys.sorted(by: <), id: \.self) { key in
                
                    HStack (spacing: 12) {
                        ForEach(buttons[key]!, id: \.self) { button in
                            CalculatorButtonView(button: button)
                        }
                    }
                }
            }
        }
    }
}



struct CalculatorButtonView: View {
    
    var button: CalculatorButton
    
    @EnvironmentObject var env: GlobalEnvironment
    
    var body: some View {
        if  button.icon == "" {
        Button(action: {
            self.env.receiveInput(calculatorButton: self.button)
        }) {
            
                Text(button.title)
                .font(.system(size: 32))
                .frame(width: self.buttonWidth(button: button), height: (UIScreen.main.bounds.width - 5 * 12) / 4)
                .foregroundColor(.white)
                .background(button.backgroundColor)
                .cornerRadius(self.buttonWidth(button: button))
                
        } } else {
            Button(action: {
                self.env.receiveInput(calculatorButton: self.button)
            }) {
                
                    Image(systemName: button.icon)
                    .font(.system(size: 32))
                    .frame(width: self.buttonWidth(button: button), height: (UIScreen.main.bounds.width - 5 * 12) / 4)
                    .foregroundColor(.white)
                    .background(button.backgroundColor)
                    .cornerRadius(self.buttonWidth(button: button))
                    
                }
        }
        
    }
    
    private func buttonWidth(button: CalculatorButton) -> CGFloat {
        if button == .zero {
            return (UIScreen.main.bounds.width - 4 * 12) / 4 * 2
        }
        
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnvironment())
    }
}

