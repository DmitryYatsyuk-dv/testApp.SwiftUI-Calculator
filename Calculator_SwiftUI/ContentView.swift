//
//  ContentView.swift
//  Calculator_SwiftUI
//
//  Created by Lucky on 25.05.2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentNumber: Double = 0
    
    var displayedString: String {
        return String(format: "%.2f", arguments: [currentNumber])
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
                NumberView(number: 1)
                Spacer()
                NumberView(number: 2)
                Spacer()
                NumberView(number: 3)
                Spacer()
                NumberView(number: 3)
            }
            
            HStack {
                NumberView(number: 4)
                Spacer()
                NumberView(number: 5)
                Spacer()
                NumberView(number: 6)
                Spacer()
                NumberView(number: 6)
            }
            
            HStack {
                NumberView(number: 7)
                Spacer()
                NumberView(number: 8)
                Spacer()
                NumberView(number: 9)
                Spacer()
                NumberView(number: 4)
            }
            
            HStack {
                NumberView(number: 1)
                Spacer()
                NumberView(number: 2)
                Spacer()
                NumberView(number: 3)
                Spacer()
                NumberView(number: 4)
            }
            
            } .padding(32)
    }
}

struct NumberView: View {
    
    var numberString: String {
        if number == .pi {
            return "π"
        }
        
        return String(Int(number))
        
    }
    
    let number: Double
    
    var body: some View {
        Text(numberString)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(width: 64, height: 64)
            .background(Color.blue)
            .cornerRadius(20)
            .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 10)
            
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
