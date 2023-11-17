//
//  StepsTabView.swift
//  steps-app
//
//  Created by Eetu Eskelinen on 14.11.2023.
//

import SwiftUI

struct StepsTabView: View {
    @EnvironmentObject var manager: HealthManager
    @State var selectedTab = "Home"
    var body: some View {
        TabView(selection: $selectedTab) {
            
            HomeView()
                .tag("Home")
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .environmentObject(manager)
            ContentView()
                .tag("Content")
                .tabItem {
                    Label("Content", systemImage: "trophy")
                }
            
            ProfileView()
                .tag("Profile")
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }}
}

#Preview {
    StepsTabView()
        .environmentObject(HealthManager())
}
