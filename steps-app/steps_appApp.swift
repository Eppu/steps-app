//
//  steps_appApp.swift
//  steps-app
//
//  Created by Eetu Eskelinen on 14.11.2023.
//

import SwiftUI

@main
struct steps_appApp: App {
    @StateObject var manager = HealthManager()
    var body: some Scene {
        WindowGroup {
            StepsTabView()
                .environmentObject(manager)
        }
    }
}
