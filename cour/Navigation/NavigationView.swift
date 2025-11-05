//
//  Navigation.swift
//  cour
//
//  Created by thomas sauvage on 04/11/2025.
//

import SwiftUI
import DesignSystem

struct NavigationView: View {
    
    var body: some View {
        NavigationStack {
            HomeView()
                .navigationTitle("Home")
            HStack{
                NavigationLink("Compteur") {
                    CounterView()
                }
                .navigationTitle("Conteur")
                .tint(.black)
                .padding(20)
                .cornerRadius(20)
                NavigationLink("Todo") {
                    TodoView()
                }
                .navigationTitle("Todo")
                .background(.main)
                .cornerRadius(20)
                
                NavigationLink("Profil") {
                    ProfilView()
                }
                .navigationTitle("Profil")
                .background(.main)
                .cornerRadius(20)
            }
            .padding()
            
        }
    }
}

#Preview {
    NavigationView()
}
