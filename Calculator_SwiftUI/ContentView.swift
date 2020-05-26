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
        return String(format: "%.2f",
                      arguments: [state.currentNumber])
    }
    
    var body: some View {
        
        VStack(alignment: .trailing, spacing: 20) {
            Spacer()
            
            Text(displayedString)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .lineLimit(3)
                .padding(.bottom, 64)
            
            HStack {
                NumberView(number: 1, state: $state)
                Spacer()
                NumberView(number: 2, state: $state)
                Spacer()
                NumberView(number: 3, state: $state)
                Spacer()
                NumberView(number: .pi, state: $state)
            }
            
            HStack {
                NumberView(number: 4, state: $state)
                Spacer()
                NumberView(number: 5, state: $state)
                Spacer()
                NumberView(number: 6, state: $state)
                Spacer()
                NumberView(number: 6, state: $state)
            }
            
            HStack {
                NumberView(number: 7, state: $state)
                Spacer()
                NumberView(number: 8, state: $state)
                Spacer()
                NumberView(number: 9, state: $state)
                Spacer()
                NumberView(number: 4, state: $state)
            }
            
            HStack {
                NumberView(number: 1, state: $state)
                Spacer()
                NumberView(number: 2, state: $state)
                Spacer()
                FunctionView(function: .sinus, state: $state)
                Spacer()
                FunctionView(function: .cosinus, state: $state)
            }
            
            } .padding(32)
    }
}

struct NumberView: View {
    let number: Double
    @Binding var state: CalculationState
    
    var numberString: String {
        if number == .pi {
            return "π"
        }
        
        return String(Int(number))
        
    }
    
    var body: some View {
        Text(numberString)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(width: 64, height: 64)
            .background(Color.blue)
            .cornerRadius(20)
            .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 10)
            
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
            .foregroundColor(.black)
            .frame(width: 64, height: 64)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(20)
            .shadow(color: Color.gray.opacity(0.9), radius: 10, x: 0, y: 10)
            .onTapGesture {
                self.state.currentNumber = self.function.operation(self.state.currentNumber)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
