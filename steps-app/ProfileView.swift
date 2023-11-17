//
//  ProfileView.swift
//  steps-app
//
//  Created by Eetu Eskelinen on 17.11.2023.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var userManager = UserManager()
    
    var body: some View {
        // Show the users basic information and a log out button
        VStack {
            Text("Logged in as: \(userManager.user?.email ?? "No user")")
            // Show username
            Text("Username: \(userManager.userName ?? "No username")")
            Button(action: { userManager.logout() }) {
                Text("Logout")
            }
        }
    }
}

#Preview {
    ProfileView()
}
