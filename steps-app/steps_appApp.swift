//
//  steps_appApp.swift
//  steps-app
//
//  Created by Eetu Eskelinen on 14.11.2023.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct steps_appApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var userManager = UserManager()
    @StateObject var manager = HealthManager()
    
    var body: some Scene {
        WindowGroup {
            // Could also use NavigationView here
            ZStack {
                if userManager.isLoggedIn {
                    // If the user is logged in, show StepsTabView
                    StepsTabView()
                        .environmentObject(manager)
                        .transition(.opacity)
                  
                } else {
                    // If the user is not logged in, show LoginView
                    LoginView()
                        .environmentObject(userManager)
                        .transition(.move(edge: .bottom))
                        
                }
            }.animation(.default, value: userManager.isLoggedIn)
        }
    }
}

