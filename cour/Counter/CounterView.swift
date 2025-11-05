//
//  exo1.swift
//  cour
//
//  Created by thomas sauvage on 03/11/2025.
//
import SwiftUI

struct CounterView: View {
    @State var counterViewModel = CounterViewModel()
    
    var body: some View {
        VStack {
            Text("\(counterViewModel.counter)")
                .font(.largeTitle)
                .padding(12)
            
            HStack{
                Menu("Add value"){
                    Button("+1") {
                        counterViewModel.add(number: 1)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .clipShape(Circle())
                    Button("+10") {
                        counterViewModel.add(number: 10)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .clipShape(Circle())
                }
               
                Button("Reset") {
                    counterViewModel.reset()
                }
                .buttonStyle(.borderedProminent)
                .tint(.main)
                .tint(.white)
            }
        }
        .padding(120)
        
    }
}

#Preview {
    CounterView()
}
