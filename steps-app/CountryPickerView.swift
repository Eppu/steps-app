//
//  CountryPickerView.swift
//  steps-app
//
//  Created by Eetu Eskelinen on 22.11.2023.
//

import SwiftUI

struct CountryPickerView: View {
    var handleMenuAction : () -> ()
    @ObservedObject var userManager = UserManager()
    var body: some View {
        //        Text("Select your country").padding()
        List(NSLocale.isoCountryCodes, id: \.self) { countryCode in
            Button(action: {
                print("Country code: \(countryCode)")
                userManager.updateUserCountry(countryCode)
                handleMenuAction()
            }) {
                HStack {
                    
                    
                    
                    Text(countryFlag(countryCode))
                    Text(Locale.current.localizedString(forRegionCode: countryCode) ?? "")
                    Spacer()
                    Text(countryCode)
                }
            }.foregroundColor(.primary)
        }
    }
}


#Preview {
    // Preview handle menu action should just print
    CountryPickerView(handleMenuAction: {print("Menu action")})
}
