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
            await pullUserData()
        } catch {
            print("error logging in")
        }
        /*
        Auth.auth().signIn(withEmail: email, password: pw) { result, error in
            if let error = error {
                print("Registration error:", error.localizedDescription)
            } else {
                print("Login successful")
            }
        }
         */
    }
    
    func register(withEmail email: String, pw: String, fName: String, lName: String) async throws {
        print("auth Signed up")
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: pw)
            self.userSession = result.user
            let user = User(id: result.user.uid, fName: fName, lName: lName, email: email)
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
    
}


/*
 #Preview {
 AuthViewModel()
 }
 */
