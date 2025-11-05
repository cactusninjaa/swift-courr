//
//  ToggleButton.swift
//  DesignSystem
//
//  Created by thomas sauvage on 04/11/2025.
//

import SwiftUI

public struct ToggleButtonView: View {
    @State private var isOn: Bool
    private var text: String
    
    public init(isOn: Bool = false, text: String) {
        self._isOn = State(initialValue: isOn)
        self.text = text
    }
    
    public var body: some View {
        Toggle(isOn: $isOn) {
            Text(text)
                .font(.headline)
        }
            .toggleStyle(SwitchToggleStyle(tint: .yellow))
            .padding()
    }
}

#Preview {
    ToggleButtonView(isOn: false, text: "Hello")
}
