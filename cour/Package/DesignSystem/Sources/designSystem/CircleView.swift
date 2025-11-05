//
//  CircleView.swift
//  DesignSystem
//
//  Created by thomas sauvage on 05/11/2025.
//

import SwiftUI

public struct CircleView: View {
    public init() {} 

    public var body: some View {
        Circle()
            .fill(Color.blue.opacity(0.8))
            .frame(width: 150, height: 150)
    }
}
