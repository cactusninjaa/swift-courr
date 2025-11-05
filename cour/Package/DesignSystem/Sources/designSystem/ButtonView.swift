//
//  ButtonView.swift
//  DesignSystem
//
//  Created by Thomas Sauvage on 04/11/2025.
//

import SwiftUI

public struct ButtonView: View {
    public let text: String
    public let action: () -> Void
    
    public init(text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text(text)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .cornerRadius(12)
                .glassEffect(.regular)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ButtonView(text: "Test button") { print("Primary tapped") }
}
