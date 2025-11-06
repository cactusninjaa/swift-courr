//
//  HomeView.swift
//  cour
//
//  Created by thomas sauvage on 03/11/2025.
//

import SwiftUI
import DesignSystem

struct HomeView: View {
    @State private var homeViewModel = HomeViewModel()
    @State private var settingsViewModel = SettingsViewModel()
    @State private var countdownValue: Int? = nil

    var body: some View {
        ZStack {
            TouchTrackingView(
                onUpdate: { touches in
                    homeViewModel.updateTouches(touches)
                },
                notificationsEnabled: settingsViewModel.notification,
                numberOfWinners: Int(settingsViewModel.numbersOfWinners.rawValue) ?? 1,
                countdownValue: $countdownValue
            )
            VStack {
                if let countdownValue = countdownValue {
                   Text("\(countdownValue)")
                       .font(.system(size: 80, weight: .bold, design: .rounded))
                       .foregroundColor(.white)
                       .transition(.scale.combined(with: .opacity))
                       .animation(.easeInOut(duration: 0.3), value:  countdownValue)
                } else {
                    TitleView(text: "Chooser")
                    SubTitleView(text: "Put your fingers on the screen")
                }
            }
         
            ForEach(Array(homeViewModel.circles.keys), id: \.self) { id in
                if let circle = homeViewModel.circles[id] {
                    CircleView()
                        .position(circle.position)
                }
            }
        }
        .background(Color.red.ignoresSafeArea())
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationLink(destination: SettingsView(settingsViewModel: settingsViewModel)) {
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
