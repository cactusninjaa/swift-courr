//
//  SettingsView.swift
//  cour
//
//  Created by thomas sauvage on 05/11/2025.
//

import SwiftUI
import DesignSystem

struct SettingsView: View {
    @State var settingsViewModel: SettingsViewModel
    
    var body: some View {
        List {
            HStack{
                Text("Winners")
                    .font(.headline)
                Spacer()
                PickerSegmented(
                    title: "Number of winners",
                    selection: $settingsViewModel.numbersOfWinners
                )
            }
            .padding()
            HStack{
                ToggleButtonView(
                    isOn: $settingsViewModel.notification,
                    text: "Vibrations"
                )
            }
        }
        .listStyle(.plain)
        .padding()
    }
}

//#Preview {
//    SettingsView()
//}
