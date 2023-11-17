//
//  UserManager.swift
//  steps-app
//
//  Created by Eetu Eskelinen on 17.11.2023.
//

import Foundation
import Firebase

class UserManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var user: User? = nil
    
    init() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                self.isLoggedIn = true
                self.user = user
                // Print all the properties of the user
                //                print("""
                //                    User properties:
                //                    uid: \(user.uid)
                //                    email: \(user.email ?? "No email")
                //                    displayName: \(user.displayName ?? "No display name")
                //                    photoURL: \(user.photoURL?.absoluteString ?? "No photo URL")
                //                    emailVerified: \(user.isEmailVerified)
                //                    """)
                
            } else {
                self.isLoggedIn = false
                self.user = nil
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            completion(error)
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
