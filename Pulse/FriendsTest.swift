//
//  FriendsTest.swift
//  Pulse
//
//  Created by Litao Li on 4/8/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct FriendsTest: View {
    @State var friendList: [String] = []
    @State var friend: String = ""
    @State var name: String = ""
    let currentUserID = "Litao"
    var body: some View {
        VStack {
            Text("hello")
            ForEach(friendList, id: \.self) { item in
                Text(item)
            }
            Text("\(name)")
        }
        .onAppear{
            
            Task {
                print("Inside Task")
                do {
                    friendList = try await fetchFriends(userID: "IRftJFGQ8EcFO0EAertjZVfLfKn1")
                } catch {
                    print("Error fetching network data: \(error)")
                }
                
//                do {
//                    name = try await fetchUserName(userID: "IRftJFGQ8EcFO0EAertjZVfLfKn1")!
//                } catch {
//                    print("Error fetching network data: \(error)")
//                }
                
            }
        }
        
    }
    
//    func fetchFriends(userID: String) async -> [String] {
//        var friendList: [String] = []
//        let db = Firestore.firestore()
//        let friendsCollection = db.collection("friends")
//        
//        do {
//            let friendsQuery = friendsCollection.whereField("primary", isEqualTo: userID)
//            let friendsSnapshot = try await friendsQuery.getDocuments()
//            
//            for document in friendsSnapshot.documents {
//                if let friendID = document["secondary"] as? String {
//                    print("friendID: \(friendID)")
//                    friendList.append(friendID)
//                    
//                }
//            }
//        } catch {
//            print("Error fetching friends: \(error.localizedDescription)")
//        }
//        return friendList
//    }
    
    func fetchFriends(userID: String) async -> [String] {
        var friendListName: [String] = []
//        var friendList: [String] = []
        do {
                // Fetch friend IDs
                let friendIDs = try await fetchFriendsID(userID: userID)
                
                // Fetch names for each friend ID
                let names = try await withThrowingTaskGroup(of: String.self) { group -> [String] in
                    var names: [String] = []
                    for friendID in friendIDs {
                        group.addTask {
                            do {
                                let name = try await fetchUserName(userID: friendID)
                                return name
                            } catch {
                                throw error
                            }
                        }
                    }
                    for try await nameResult in group {
                        names.append(nameResult)
                    }
                    return names
                }
                
                return names
            } catch {
                print("Error fetching friends' names: \(error.localizedDescription)")
            }
        
        func fetchFriendsID(userID: String) async -> [String] {
            var friendList: [String] = []
            let db = Firestore.firestore()
            let friendsCollection = db.collection("friends")
            
            do {
                let friendsQuery = friendsCollection.whereField("primary", isEqualTo: userID)
                let friendsSnapshot = try await friendsQuery.getDocuments()
                
                for document in friendsSnapshot.documents {
                    if let friendID = document["secondary"] as? String {
                        print("friendID: \(friendID)")
                        friendList.append(friendID)
                        
                    }
                }
            } catch {
                print("Error fetching friends: \(error.localizedDescription)")
            }
            return friendList
        }
        
        func fetchUserName(userID: String) async throws -> String {
            let db = Firestore.firestore()
            let usersCollection = db.collection("users")
            var name: String = ""
            
            do {
                let userDoc = try await usersCollection.document(userID).getDocument()
                if let userName = userDoc.data()?["name"] as? String {
                    name = userName
                }
            } catch {
                print("Error fetching user name: \(error.localizedDescription)")
                throw error
            }
            return name
        }
        return friendListName
    }
}

#Preview {
    FriendsTest()
}
