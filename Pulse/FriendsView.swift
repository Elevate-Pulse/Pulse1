//
//  FriendsView.swift
//  Pulse
//
//  Created by Litao Li on 4/8/24.
//

import SwiftUI
import FirebaseFirestore
import Firebase

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool

    var body: some View {
        HStack {
            TextField("search to add friends", text: $searchText)
                .padding(.leading, 20)
                .padding(.vertical, 10)
                .padding(.trailing, 10)
                .background(Color(.systemGray5))
                .cornerRadius(8)
                .padding(.horizontal)
                .onTapGesture {
                    isSearching = true
                }

            if isSearching {
                Button(action: {
                    searchText = ""
                    isSearching = false
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .padding(.horizontal, 8)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

 
struct Friend: Identifiable {
    let id = UUID()
    var name: String
    var personalityType: String
}

struct FriendsView: View {
    @State var friendList: [String] = []
//    let currentUserID = "IRftJFGQ8EcFO0EAertjZVfLfKn1"
    var currentUserID: String {
        guard let uid = Auth.auth().currentUser?.uid else {
            // Handle case where current user is not authenticated
            return ""
        }
        return uid
    }
//    @State private var friends = ["Alice", "Bob", "Charlie", "Dave"]
    @State var searchText = ""
    @State var isSearching = false
    
    var body: some View {
        
        VStack {
            HStack {
//                VStack(alignment: .leading) {
//                    Text("friends")
//                        .font(.title)
//                }
                Text("friends")
                    .font(.title)
                    .padding(.trailing, 200)
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue) // Assuming all are online, for example
            }
//            .padding(.bottom, 20)
            .padding(.top, 10)
            
            Divider()
                .background(Color(#colorLiteral(red: 0.0431372549, green: 0.1960784314, blue: 0.1568627451, alpha: 1))) // Set the background color of the divider
                .frame(height: 10)
            
            SearchBar(searchText: $searchText, isSearching: $isSearching)
                    .padding()
            NavigationView {
                    List(friendList, id: \.self) { friend in
                        HStack {
                            Circle()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.green) // Assuming all are online, for example
                            Text(friend)
                                .font(.headline)
                            Spacer()
                        }
                    }
                    .navigationTitle("my friends (\(friendList.count))")
//                    .toolbar {
//                        Button(action: addFriend) {
//                            Image(systemName: "plus")
//                        }
//                    }
            }
        }
        .onAppear {
            Task {
                print("Inside Task")
                do {
                    friendList = try await fetchFriends(userID: "IRftJFGQ8EcFO0EAertjZVfLfKn1")
                } catch {
                    print("Error fetching friends data: \(error)")
                }
                
            }
        }
        
    }

    
    
/////////////////////////////////////////////////////////////////////////////////////FUNCTIONS////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
    /////////////////////////////////////////////////////////////////////////////////////FUNCTIONS////////////////////////////////////////////////////////////////////////////////////////////////////////////

}

#Preview {
    FriendsView()
}
