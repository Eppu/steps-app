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
    @Published var userName: String? = nil
    
    init() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                self.isLoggedIn = true
                self.user = user
                self.loadUserName()
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
                self.userName = nil
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
        // Log in. After the user has logged in, load the users username
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                // If there is an error, print it
                print("Error logging in: \(error.localizedDescription)")
                completion(error)
            } else {
                print("Login successful")
                completion(nil)
            }
        }
    }
    
    func loadUserName() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("No user is logged in")
            return
        }
        
        print("Loading username")
        let db = Firestore.firestore()
        let profileRef = db.collection("profile").document(uid)  // Use the correct collection name
        
        print("Got profile ref for uid: \(uid))")
        print("ProfileRef", profileRef)
        
        profileRef.getDocument { (document, error) in
            if let document = document, document.exists {
                print("Document data: \(document.data() ?? [:])")
                if let userName = document["userName"] as? String {
                    self.userName = userName
                    print("Username: \(userName)")
                } else {
                    print("No username found, generating one")
                    // If the user does not have a username, generate a random one
                    let randomUserName = self.generateRandomUserName()
                    self.updateUserName(randomUserName)
                }
            } else {
                print("Error fetching user profile: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
    
    func updateUserName(_ newUserName: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let db = Firestore.firestore()
        let profilesRef = db.collection("profile")

        // Check if the new username already exists
        profilesRef.whereField("userName", isEqualTo: newUserName).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error checking username uniqueness: \(error.localizedDescription)")
            } else if let snapshot = snapshot {
                if snapshot.isEmpty {
                    // Username is unique, update it
                    let profileRef = db.collection("profile").document(uid)
                    profileRef.setData(["userName": newUserName], merge: true) { error in
                        if let error = error {
                            print("Error updating username: \(error.localizedDescription)")
                        } else {
                            self.userName = newUserName
                            print("Username updated successfully")
                        }
                    }
                } else {
                    // Username is not unique, generate a new random one and check again
                    let newRandomUserName = self.generateRandomUserName()
                    self.updateUserName(newRandomUserName)
                }
            }
        }
    }

    
    func generateRandomUserName() -> String {
        // TODO: Use something more human readable
        return UUID().uuidString
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
            self.user = nil
            self.userName = nil
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
    
    func setUserName(username: String) {
        // The usernames are stored in Firestore under the profile collection
        print("Setting username")
        let db = Firestore.firestore()
        let docRef = db.collection("profile").document(user!.uid)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                // If the user has already set a username, update it
                docRef.updateData([
                    "username": username
                ]) { err in
                    if let err = err {
                        print("Error updating username: \(err)")
                    } else {
                        print("Username successfully updated")
                    }
                }
            } else {
                // If the user has not set a username, create a new document
                docRef.setData([
                    "username": username
                ]) { err in
                    if let err = err {
                        print("Error setting username: \(err)")
                    } else {
                        print("Username successfully set")
                    }
                }
            }
        }
    }
}



// https://stackoverflow.com/questions/70612923/how-do-i-wait-for-a-firebase-function-to-complete-before-continuing-my-code-flow
