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
        ZStack{
            Circle()
                .fill(Color.white.opacity(1))
                .frame(width: 150, height: 150)
            Circle()
                .fill(Color.red.opacity(1))
                .frame(width: 130, height: 130)
            Circle()
                .fill(Color.white.opacity(1))
                .frame(width: 110, height: 110)
        }
    }
}

#Preview {
    CircleView()
}
