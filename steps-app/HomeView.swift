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
                ActivityCard()
                ActivityCard()
            }.padding(.horizontal)
        }
    }
}

#Preview {
    HomeView()
}
