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
            Button("Add +10") {
                counterViewModel.add(number: 10)
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            Button("Reset") {
                counterViewModel.reset()
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
        }
        .background(.teal)
        .cornerRadius(16)
        .padding()
    }
}

#Preview {
    CounterView()
}
