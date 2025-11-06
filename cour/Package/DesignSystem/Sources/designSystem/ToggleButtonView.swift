//
//  ToggleButton.swift
//  DesignSystem
//
//  Created by thomas sauvage on 04/11/2025.
//

import SwiftUI

public struct ToggleButtonView: View {
    @Binding public var isOn: Bool
    private var text: String
    
    public init(isOn: Binding<Bool>, text: String) {
        self._isOn = isOn
        self.text = text
    }
    
    public var body: some View {
        Toggle(isOn: $isOn) {
            Text(text)
                .font(.headline)
        }
        .toggleStyle(SwitchToggleStyle(tint: .red))
        .padding()
    }
}
