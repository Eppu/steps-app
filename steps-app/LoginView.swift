//
//  LoginView.swift
//  steps-app
//
//  Created by Eetu Eskelinen on 17.11.2023.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @ObservedObject var userManager = UserManager()
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @State private var isLoginSuccessful = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Steps app")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button(action: { signIn() }) {
                    Text("Login")
                }
                Button(action: { signOut() }) {
                    Text("Logout")
                }
                // Show possible error
                Text(error).foregroundColor(.red)
            }
        }
    }
    
    func signIn() {
        print("Logging in")
        // If login is successful, set isLoginSuccessful to true
        userManager.login(email: email, password: password, completion: { (error) in if error != nil { self.error = error!.localizedDescription } else { self.isLoginSuccessful = true } })
    }
    
    func signOut() {
        print("Logging out")
        userManager.logout()
    }
}

#Preview {
    LoginView()
}
