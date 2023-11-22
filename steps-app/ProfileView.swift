//
//  ProfileView.swift
//  steps-app
//
//  Created by Eetu Eskelinen on 17.11.2023.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var userManager = UserManager()
    
    @State private var isCountryPickerVisible = false
    
    var body: some View {
        VStack {
            Text("Logged in as: \(userManager.user?.email ?? "No user")")
            // Show username
            Text("Username: \(userManager.userName ?? "No username")")
            Button(action: { userManager.logout() }) {
                Text("Logout")
            }
            HStack {
                Text("Country:")
                Button(action: { withAnimation { isCountryPickerVisible.toggle() } }) {
                    if((userManager.userCountry) != nil) {
                        HStack{
                            Text("\(countryFlag(userManager.userCountry ?? ""))")
                            Text("\(countryName(userManager.userCountry ?? ""))")
                        }
                    } else {
                        Text("Pick a country")
                    }
                }
            }
            
            if isCountryPickerVisible {
                CountryPickerView(handleMenuAction: {
                    userManager.loadUserCountry()
                    isCountryPickerVisible.toggle()
                    
                }).transition(.move(edge: .bottom))
            }
            
        }
    }
}

func countryName(_ countryCode: String) -> String {
    Locale.current.localizedString(forRegionCode: countryCode) ?? "Unknown"
}

func countryFlag(_ countryCode: String) -> String {
    String(String.UnicodeScalarView(countryCode.unicodeScalars.compactMap {
        UnicodeScalar(127397 + $0.value)
    }))
}

#Preview {
    ProfileView()
}
