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
    let searchText = "test"
    let currentUserID = "Litao"
    var body: some View {
        VStack {
            Text("hello")
//            ForEach(friendList, id: \.self) { item in
//                Text(item)
//            }
//            Text("\(name)")
        }
        .onAppear{
            //////////////////////////////////////////////////////////// Test out addFriiend  function /////////////////////////////////////////////////////////
//            Task {
//                do {
//                    try await addFriend(userID: "Alex")
//                    print("Friend added successfully")
//                } catch {
//                    print("Error adding friend: \(error.localizedDescription)")
//                }
//            }
            /////////////////////////////////////////////////////////////// Test out addFriiend  function /////////////////////////////////////////////////////////
            
            //////////////////////////////////////////////////////////// Test out returnSearchFriend function /////////////////////////////////////////////////////////
            Task {
                do {
                    let searchResults = try await returnSearchFriend(searchedText: searchText)
                    // Print the search results to the console
                    for result in searchResults {
                        print("Name: \(result.name), ID: \(result.id)")
                    }
                } catch {
                    print("Error searching for friends: \(error.localizedDescription)")
                }
            }
            //////////////////////////////////////////////////////////// Test out returnSearchFriend function /////////////////////////////////////////////////////////
            
//            Task {
//                print("Inside Task")
//                do {
//                    friendList = try await fetchFriends(userID: "IRftJFGQ8EcFO0EAertjZVfLfKn1")
//                } catch {
//                    print("Error fetching network data: \(error)")
//                }
//                
////                do {
////                    name = try await fetchUserName(userID: "IRftJFGQ8EcFO0EAertjZVfLfKn1")!
////                } catch {
////                    print("Error fetching network data: \(error)")
////                }
//                
//            }
        }
        
    }
    
    func addFriend(userID: String) async throws {
        let db = Firestore.firestore()
        let friendsCollection = db.collection("friends")
//        let currentUserID = Auth.auth().currentUser!.uid
        let currentUserID = "Litao"
        
        // Check if a friendship document already exists with the given users
        let existingFriendshipQuery = friendsCollection
            .whereField("primary", isEqualTo: currentUserID)
            .whereField("secondary", isEqualTo: userID)
        
        let existingFriendshipSnapshot = try await existingFriendshipQuery.getDocuments()
        
        if existingFriendshipSnapshot.documents.isEmpty {
            // Friendship document doesn't exist, so add it
            // Add friendship with "primary" field as the current user and "secondary" field as the provided userID
            try await friendsCollection.addDocument(data: [
                "primary": currentUserID,
                "secondary": userID
            ])
            
            // Add friendship with "primary" field as the provided userID and "secondary" field as the current user
            try await friendsCollection.addDocument(data: [
                "primary": userID,
                "secondary": currentUserID
            ])
            
            print("Friendship added successfully")
        } else {
            print("Friendship already exists")
        }
    }
    
    func returnSearchFriend(searchedText: String) async -> [(name: String, id: String)] {
        let db = Firestore.firestore()
        let usersCollection = db.collection("users")
        var users: [(name: String, id: String)] = []
        
        do {
            // Construct a query to find users whose name contains the searched text
            let querySnapshot = try await usersCollection.whereField("name", isGreaterThanOrEqualTo: searchedText)
                                                         .whereField("name", isLessThan: searchedText + "\u{f8ff}")
                                                         .getDocuments()
            
            // Iterate through the query results
            for document in querySnapshot.documents {
                let data = document.data()
                if let name = data["name"] as? String, let id = data["id"] as? String {
                    // Append the name and ID to the users array
                    users.append((name: name, id: id))
                }
            }
        } catch {
            print("Error searching for users: \(error.localizedDescription)")
        }
        
        return users
    }
    
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
