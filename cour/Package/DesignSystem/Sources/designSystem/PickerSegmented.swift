//
//  PickerSegemented.swift
//  DesignSystem
//
//  Created by thomas sauvage on 05/11/2025.
//

import SwiftUI

public struct PickerSegmented<T: Hashable & CaseIterable & Identifiable & RawRepresentable>: View where T.RawValue == String {
    
    public let title: String
    @Binding public var selection: T

    public init(title: String, selection: Binding<T>) {
        self.title = title
        self._selection = selection
    }

    public var body: some View {
        Picker(title, selection: $selection) {
            ForEach(Array(T.allCases)) { option in
                Text(option.rawValue)
                    .tag(option)
            }
        }
        .pickerStyle(.segmented)
    }
}
