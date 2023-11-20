//
//  HomeView.swift
//  steps-app
//
//  Created by Eetu Eskelinen on 14.11.2023.
//

import SwiftUI
import Foundation

struct HomeView: View {
    @EnvironmentObject var manager: HealthManager
    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                // TODO: Figure out how to mock HealthKit steps data for preview
                ForEach(manager.activities.sorted(by: { $0.value.id < $1.value.id}), id: \.key) { item in
                    ActivityCard(activity: item.value)
                }
                //               ActivityCard(activity: Activity(id: 1, title: "Steps today", subtitle: "Something", image: "figure.walk", amount: "7364"))
            }.padding(.horizontal)
            Text("Steps for previous days")
                .padding()
            VStack {
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                    ForEach(manager.previousDaysSteps, id: \.self) { item in
                        ActivityCard(
                            activity:
                                Activity(
                                    id: 1,
                                    title: "\(item.date.formatted(.dateTime.day().month().year()))",
                                    subtitle: "",
                                    image: "figure.walk",
                                    amount: String(item.stepCount)))
                    }
                }.padding(.horizontal)
            }
        }
    }
    
}

#Preview {
    HomeView()
        .environmentObject(HealthManager())
}
