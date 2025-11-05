//
//  HomeViewModel.swift
//  cour
//
//  Created by thomas sauvage on 05/11/2025.
//

import SwiftUI

@Observable
class HomeViewModel {
    struct CircleData {
        var position: CGPoint
    }

    var circles: [Int: CircleData] = [:]

    func updateTouches(_ touches: [TouchTrackingView.TouchData]) {
        var newCircles: [Int: CircleData] = [:]
        for touch in touches {
            newCircles[touch.id] = CircleData(position: touch.location)
        }
        circles = newCircles
    }
}
