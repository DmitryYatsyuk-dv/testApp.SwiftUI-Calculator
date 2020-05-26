//
//  ContentView.swift
//  Calculator_SwiftUI
//
//  Created by Lucky on 25.05.2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import SwiftUI

struct CalculationState {
    var currentNumber: Double = 0

    var storedNumber: Double?
    var storedAction: ActionView.Action?
    
    
    mutating func appendNumber(_ number: Double) {
        if number.truncatingRemainder(dividingBy: 1) == 0 && currentNumber.truncatingRemainder(dividingBy: 1) == 0 {
            currentNumber = 10 * currentNumber + number
            //3 5 -> 30 + 5 = 35
        } else {
            currentNumber = number
        }
    }
}

struct ContentView: View {
    
    @State var state = CalculationState()
    var displayedString: String {
        return String(format: "%.1f",
                      arguments: [state.currentNumber])
    }
    
    var body: some View {
        
        VStack(alignment: .trailing, spacing: 20) {
            Spacer()
            Text(displayedString)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                .lineLimit(3)
                .padding(.bottom, 30)
            
            HStack {
                FunctionView(function: .cosinus, state: $state)
                Spacer()
                FunctionView(function: .sinus, state: $state)
                Spacer()
                FunctionView(function: .tangens, state: $state)
                Spacer()
                ActionView(action: .multiply, state: $state)
            }
            
            HStack {
                NumberView(number: 7, state: $state)
                Spacer()
                NumberView(number: 8, state: $state)
                Spacer()
                NumberView(number: 9, state: $state)
                Spacer()
                ActionView(action: .divide, state: $state)
            }
            
            HStack {
                NumberView(number: 4, state: $state)
                Spacer()
                NumberView(number: 5, state: $state)
                Spacer()
                NumberView(number: 6, state: $state)
                Spacer()
                ActionView(action: .plus, state: $state)
            }
            
            HStack {
                NumberView(number: 1, state: $state)
                Spacer()
                NumberView(number: 2, state: $state)
                Spacer()
                NumberView(number: 3, state: $state)
                Spacer()
                ActionView(action: .minus, state: $state)
            }
            
            HStack {
                ActionView(action: .clear, state: $state)
                Spacer()
                NumberView(number: 0, state: $state)
                Spacer()
                NumberView(number: .pi, state: $state)
                Spacer()
                ActionView(action: .equal, state: $state)
            }
        } .padding(32)
            .background((LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4431372549, green: 0.09019607843, blue: 0.9176470588, alpha: 1)), Color(#colorLiteral(red: 0.9176470588, green: 0.3764705882, blue: 0.3764705882, alpha: 1))]), startPoint: .top, endPoint: .bottom)))
        .edgesIgnoringSafeArea(.all)
    }
}

//extension Double {
//    static let myNumber: Double = 1.2345
//}

struct NumberView: View {
    
    let number: Double
    @Binding var state: CalculationState
    
    var numberString: String {
        if number == .pi {
            return "π"
        }
//        else if number == .myNumber {
//            return "N"
//        }
        return String(Int(number))
    }
    
    var body: some View {
        Text(numberString)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(width: 64, height: 64)
            .background(Color(#colorLiteral(red: 0.4561699897, green: 0.4310722166, blue: 0.8694677982, alpha: 0.7091984161)))
            .cornerRadius(20)
            .shadow(color: Color(#colorLiteral(red: 0.1177823604, green: 0.06738549197, blue: 0.05344382227, alpha: 1)).opacity(0.5),
                    radius: 10, x: 5, y: 10)
            
            .onTapGesture {
                self.state.appendNumber(self.number)
        }
    }
}

struct FunctionView: View {
    enum MathFunction {
        case sinus, cosinus, tangens
        
        func string() -> String {
            
            switch self {
            case .sinus:    return "sin"
            case .cosinus:  return "cos"
            case .tangens:  return "tan"
            }
        }
        
        func operation(_ input: Double) -> Double {
            
            switch self {
            case .sinus:    return sin(input)
            case .cosinus:  return cos(input)
            case .tangens:  return tan(input)
            }
        }
    }
    
    var function: MathFunction
    @Binding var state: CalculationState
    
    var body: some View {
        return Text (function.string())
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(Color(#colorLiteral(red: 0.1173504243, green: 0.1270578688, blue: 0.1411603744, alpha: 1)))
            .frame(width: 64, height: 64)
            .background(Color(#colorLiteral(red: 0.6588104395, green: 0.9348533816, blue: 0.9619091053, alpha: 1)).opacity(0.7))
            .cornerRadius(20)
            .shadow(color: Color(.gray).opacity(0.8),
                    radius: 10, x: 0, y: 10)
            .onTapGesture {
                self.state.currentNumber = self.function.operation(self.state.currentNumber)
        }
    }
}

struct ActionView: View {
    
    enum Action {
        case equal, clear, plus, minus, multiply, divide
        
        func image() -> Image {
            switch self {
            case .equal:    return Image(systemName: "equal")
            case .clear:    return Image(systemName: "flame")
            case .divide:   return Image(systemName: "divide")
            case .minus:    return Image(systemName: "minus")
            case .multiply: return Image(systemName: "multiply")
            case .plus:     return Image(systemName: "plus")
            }
        }
        
        func calculate(_ input1: Double, _ input2: Double) -> Double? {
            
            switch self {
            case .plus:     return input1 + input2
            case .minus:    return input1 - input2
            case .multiply: return input1 * input2
            case .divide:   return input1 / input2
                
            default:        return nil
            }
        }
    }
    
    let action: Action
    @Binding var state: CalculationState
    
    var body: some View {
        action.image()
            .font(Font.title.weight(.bold))
            .foregroundColor(.white)
            .frame(width: 64, height: 64)
            .background(Color(#colorLiteral(red: 0.8959985723, green: 0.4842626851, blue: 0.4679731037, alpha: 0.9854719606)))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.4),
                    radius: 10, x: 5, y: 10)
            .onTapGesture {
                self.tapped()
        }
    }
    
    private func tapped() {
        
        switch action {
        case .clear:
            state.currentNumber = 0
            state.storedNumber = nil
            state.storedAction = nil
            break
            
        case .equal:
            guard let storedAction = state.storedAction else { return }
            guard let storedNumber = state.storedNumber else { return }
            guard let result = storedAction.calculate(storedNumber, state.currentNumber) else { return }
            
            state.currentNumber = result
            state.storedNumber = nil
            state.storedAction = nil
            break
        default:
            state.storedNumber = state.currentNumber
            state.currentNumber = 0
            state.storedAction = action
             break
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
