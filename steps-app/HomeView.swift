//
//  HomeView.swift
//  steps-app
//
//  Created by Eetu Eskelinen on 14.11.2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var manager: HealthManager
    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                ActivityCard(activity: Activity(id: 1, title: "Steps today", subtitle: "Something", image: "figure.walk", amount: "10,641"))
                ActivityCard(activity: Activity(id: 1, title: "Steps today", subtitle: "Something", image: "figure.walk", amount: "7364"))
            }.padding(.horizontal)
        }
    }
}

#Preview {
    HomeView()
}
