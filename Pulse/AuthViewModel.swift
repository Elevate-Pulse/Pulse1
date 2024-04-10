//
//  AuthViewModel.swift
//  Pulse
//
//  Created by Peter Guan on 3/23/24.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    init() {
        self.userSession = Auth.auth().currentUser
        Task {
            await pullUserData()
        }
    }
    
    func login(withEmail email: String, pw: String) async throws {
            print("auth sign in")
            do {
                let result = try await Auth.auth().signIn(withEmail: email, password: pw)
                self.userSession = result.user
                await updateLoginCount() // Update timesLoggedIn
                await pullUserData()
            } catch {
                print("error logging in")
                throw error // Rethrow the error for handling in LoginView
            }
        }

        // New method to update timesLoggedIn
        public func updateLoginCount() async {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let userRef = Firestore.firestore().collection("users").document(uid)
            do {
                try await userRef.updateData(["timesLoggedIn": FieldValue.increment(Int64(1))])
            } catch {
                print("Error updating login count: \(error.localizedDescription)")
            }
        }
    func register(withEmail email: String, pw: String, name: String) async throws {
        print("auth Signed up")
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: pw)
            self.userSession = result.user
            let user = User(id: result.user.uid, name: name, email: email, timesLoggedIn: 0, initialSurvey: false, personalityType: "Undetermined", socialCurrentProgress: 0, surroundingsCurrentProgress: 0, convenienceCurrentProgress: 0, securityCurrentProgress: 0, engagementCurrentProgress: 0, socialLvl: 1, surroundingsLvl: 1, convenienceLvl: 1, securityLvl: 1, engagementLvl: 1)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await pullUserData()
        } catch {
            print("error regstering user")
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("error logging out")
        }
    }
    
    func pullUserData() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        print("current user is \(self.currentUser)")
    }
    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else {
            throw NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"])
        }
        
        do {
            // Delete user data from Firestore
            let userRef = Firestore.firestore().collection("users").document(user.uid)
            try await userRef.delete()
            
            // Delete user account from Firebase Authentication
            try await user.delete()
            
            // Update local session and current user
            self.userSession = nil
            self.currentUser = nil
            
        } catch {
            throw error
        }
    }
    
}


/*
 #Preview {
 AuthViewModel()
 }
 */
