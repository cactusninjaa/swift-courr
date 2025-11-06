//
//  SubTitleView.swift
//  DesignSystem
//
//  Created by thomas sauvage on 06/11/2025.
//

import SwiftUI

public struct SubTitleView: View {
    @State private var text: String
    
    public init(text: String) {
        self.text = text
    }
    
    public var body: some View {
        Text(text)
            .font(.headline)
            .fontWeight(.bold)
            .foregroundStyle(.white)
    }
}
