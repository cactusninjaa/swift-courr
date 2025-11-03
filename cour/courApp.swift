//
//  courApp.swift
//  cour
//
//  Created by thomas sauvage on 03/11/2025.
//

import SwiftUI

@main
struct courApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {

                NavigationLink("Aller au compteur") {
                    CounterView()
                }
                .navigationTitle("Conteur")
                NavigationLink("Todo") {
                    TodoView()
                }
                .navigationTitle("Todo")

                NavigationLink("Profil") {
                    ProfilView()
                }
                .navigationTitle("Profil")

            }
        }
    }
}
