//
//  CounterViewModel.swift
//  cour
//
//  Created by thomas sauvage on 03/11/2025.
//

import SwiftUI

@Observable
class CounterViewModel {
    var counter: Int = 0
    func add(number: Int){
        counter += number
    }
    func reset() {
        counter = 0
    }
}
