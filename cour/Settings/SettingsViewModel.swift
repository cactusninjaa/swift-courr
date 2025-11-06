//
//  SettingsViewModel.swift
//  cour
//
//  Created by thomas sauvage on 05/11/2025.
//

import SwiftUI

@Observable
class SettingsViewModel {
    var notification: Bool = true
    var numbersOfWinners: PossibleWinner = .one

    enum PossibleWinner: String, CaseIterable, Identifiable {
        case one = "1"
        case two = "2"
        case three = "3"
        case four = "4"

        var id: String { rawValue }
    }
}
