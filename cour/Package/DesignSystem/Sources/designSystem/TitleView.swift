//
//  TitleView.swift
//  DesignSystem
//
//  Created by thomas sauvage on 06/11/2025.
//

import SwiftUI

public struct TitleView: View {
    @State private var text: String
    
    public init(text: String) {
        self.text = text
    }
    
    public var body: some View {
        Text(text)
            .font(.largeTitle)
            .fontWeight(.heavy)
            .foregroundStyle(.white)
            .textCase(.uppercase)
    }
    
}
