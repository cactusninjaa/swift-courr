//
//  HomeView.swift
//  cour
//
//  Created by thomas sauvage on 03/11/2025.
//

import SwiftUI
import DesignSystem

struct HomeView: View {
    @State private var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            TouchTrackingView { touches in
                viewModel.updateTouches(touches)
            }
            
            ForEach(Array(viewModel.circles.keys), id: \.self) { id in
                if let circle = viewModel.circles[id] {
                    CircleView()
                        .position(circle.position)
                }
            }
        }
        .background(Color.red.ignoresSafeArea())
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gearshape")
                        .imageScale(.large)
                }
            }
        }
    }
}


#Preview {
    HomeView()
}
