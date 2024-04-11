//
// FriendsView.swift
// Pulse
//
// Created by Litao Li on 4/8/24.
//
import SwiftUI
import FirebaseFirestore
import Firebase
struct SearchBar: View {
  @Binding var searchText: String
  @Binding var isSearching: Bool
  var body: some View {
    HStack {
      TextField("Search for friends", text: $searchText)
        .autocorrectionDisabled()
        .autocapitalization(.none)
        .padding(.leading, 24)
        .padding(.vertical, 8)
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .overlay(
          RoundedRectangle(cornerRadius: 15)
            .stroke(.black, lineWidth: 1)
        )
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
            .padding(.trailing, 24)
            .foregroundColor(.gray)
        }
      }
    }
    .padding(.top)
  }
}

//struct Friend: Identifiable {
//  let id = UUID()
//  var name: String
////  var personalityType: String
//  var color: Color
//}
extension Array where Element == (name: String, id: String, color: Color) {
    static func == (lhs: Self, rhs: Self) -> Bool {
        guard lhs.count == rhs.count else { return false }
        for i in 0..<lhs.count {
            if lhs[i].id != rhs[i].id {
                return false
            }
        }
        return true
    }
}



struct FriendsView: View {
  @State private var friends: [(name: String, id: String, color: Color)] = [
//    Friend(name: "Maya"/*, personalityType: "Type A"*/, color: .purple),
//    Friend(name: "Litao"/*, personalityType: "Type B"*/, color: .pink),
//    Friend(name: "Yinglin"/*, personalityType: "Type C"*/, color: .green),
//    Friend(name: "Peter"/*, personalityType: "Type D"*/, color: .blue),
//    Friend(name: "Diana"/*, personalityType: "Type E"*/, color: .yellow)
  ]
    
  @State var searchText = ""
  @State var isSearching = false
  @State private var searchResults: [(name: String, id: String)] = []
  func searchFriends() async {
    if !searchText.isEmpty {
      do {
        // Call the search function and update the searchResults state
        searchResults = try await returnSearchFriend(searchedText: searchText)
      }
    } else {
      // Clear search results if the search text is empty
      searchResults = []
    }
  }
  var body: some View {
    ScrollView {
      VStack {
        Text("Friends")
          .font(Font.custom("Comfortaa-Light", size: 20))
          .padding(.leading)
          .frame(maxWidth: .infinity, alignment: .leading)
        SearchBar(searchText: $searchText, isSearching: $isSearching)
          .onChange(of: searchText) { _ in
            Task {
              await searchFriends()
            }
          }
        VStack(alignment: .leading, spacing: 10) {
          ForEach(searchResults, id: \.id) { result in
            HStack{
              Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(friends.first { $0.name == result.name }?.color ?? Color.gray)
              Text(result.name)
                .font(.subheadline)
                .foregroundStyle(Color.black)
              Spacer()
              Button(action: {
                Task {
                  try await addFriend(userID: result.id)
                }
              }) {
                Image(systemName: "plus.circle")
                  .foregroundColor(.blue)
              }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 0.5))
          }
          .padding()
        }
        VStack(alignment: .leading, spacing: 10) {
            ForEach(friends, id: \.id) { friend in
//            NavigationLink(destination: Text(friend.name)) {
              HStack {
                Circle()
                  .frame(width: 30, height: 30)
                  .foregroundColor(friend.color)
                Text(friend.name)
                  .font(.subheadline)
                  .foregroundStyle(Color.black)
                Spacer()
                Image(systemName: "chevron.right")
              }
              .padding()
              .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 0.5))
//            }
          }
        }
        .padding()
      }
    }
    .background(Color("cream"))
    .onAppear {
      Task {
//          await fetchFriends(userID: Auth.auth().currentUser?.uid)
          friends = await fetchFriends(userID: Auth.auth().currentUser!.uid)
      }
    }
    .onChange(of: searchText) { _ in
                // Triggered when friends list changes (i.e., when a friend is added)
                Task {
                    friends = await fetchFriends(userID: Auth.auth().currentUser!.uid)
                }
            }
    

  }
/////////////////////////////////////////////////////////////////////////////////////FUNCTIONS////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
    
   func addFriend(userID: String) async throws {
    let db = Firestore.firestore()
    let friendsCollection = db.collection("friends")
    let currentUserID = Auth.auth().currentUser?.uid ?? "exampleID"
    // Check if a friendship document already exists with the given users
    let existingFriendshipQuery = friendsCollection
     .whereField("primary", isEqualTo: userID)
     .whereField("secondary", isEqualTo: currentUserID)
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
//     await loadFriends()
   }
    
    func fetchFriends(userID: String) async -> [(name: String, id: String, color: Color)] {
      var friends: [(name: String, id: String, color: Color)] = []
  //    var friendList: [String] = []
      do {
          // Fetch friend IDs
          let friendIDs = try await fetchFriendsID(userID: userID)
          // Fetch names for each friend ID
          let friendDetails = try await withThrowingTaskGroup(of: (String, Color).self) { group -> [(String, Color)] in
            var details: [(String, Color)] = []
            for friendID in friendIDs {
              group.addTask {
                do {
                  let name = try await fetchUserName(userID: friendID)
                    let personalityTypeColor = await fetchUserPersonalityTypeColor(userID: friendID)
                    return (name, personalityTypeColor)
                } catch {
                  throw error
                }
              }
            }
              for try await friendDetailResult in group {
                  details.append(friendDetailResult)
              }
              
              return details
          }
          
          for (name, color) in friendDetails {
              friends.append((name: name, id: friendIDs[friends.count], color: color))
          }
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
          print("Name: \(name)")
        return name
      }
      return friends
    }
    
    func fetchUserPersonalityTypeColor(userID: String) async -> Color {
        let db = Firestore.firestore()
        let surveyResponsesCollection = db.collection("survey_responses")
        var personalityType: String = ""
        
        do {
            // Construct a query to get the document with the matching userID
            let querySnapshot = try await surveyResponsesCollection.whereField("userID", isEqualTo: userID).getDocuments()
            
            // Check if the query returned any documents
            guard let document = querySnapshot.documents.first else {
                print("No document found for userID: \(userID)")
                // Handle the case where no document is found (return default color or handle differently)
                return .gray // Return a default color
            }
            
            // Retrieve the personalityType from the document
            if let personality = document.data()["personalityType"] as? String {
                personalityType = personality
                print("Personality Type: \(personalityType)")
            } else {
                print("Personality type not found in document")
                // Handle the case where personalityType is not found in the document
                return .gray // Return a default color
            }
        } catch {
            print("Error fetching user personality type: \(error.localizedDescription)")
            // Handle the error (return default color or handle differently)
            return .gray // Return a default color
        }
        
        // Determine and return the color based on the personality type
        return colorForType(type: personalityType)
    }

    
    private func colorForType(type: String) -> Color {
        switch type {
        case "Outgoing Spirit":
            return Color("yellow_c")
        case "Open-Minded Explorer":
            return Color("peach") // Ensure this color is defined in your asset catalog or use a SwiftUI color approximation
        case "Private Resident":
            return Color("light_green") // Define this color too
        case "Engaged Citizen":
            return Color("purple_c")
        case "Easygoing Neighbor":
            return Color("blue_c")
        default:
            return Color.gray // Fallback color
        }
    }
    
//  func loadFriends() async {
//      // Assume this gets the current user's ID correctly
//      guard let userID = Auth.auth().currentUser?.uid else { return }
//      let fetchedFriendNames = await fetchFriends(userID: userID)
//      // Convert fetched names to Friend models; adjust according to your data structure
//      DispatchQueue.main.async {
//        self.friends = fetchedFriendNames.map { Friend(name: $0, color: .gray) } // Adjust based on actual data structure
//      }
//  }
/////////////////////////////////////////////////////////////////////////////////////FUNCTIONS////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
#Preview {
  FriendsView()
}
////
////  FriendsView.swift
////  Pulse
////
////  Created by Litao Li on 4/8/24.
////
//
//import SwiftUI
//import FirebaseFirestore
//import Firebase
//
//struct SearchBar: View {
//    @Binding var searchText: String
//    @Binding var isSearching: Bool
//
//    var body: some View {
//        HStack {
//            TextField("search to add friends", text: $searchText)
//                .padding(.leading, 20)
//                .padding(.vertical, 10)
//                .padding(.trailing, 10)
//                .background(Color(.systemGray5))
//                .cornerRadius(8)
//                .padding(.horizontal)
//                .onTapGesture {
//                    isSearching = true
//                }
//
//            if isSearching {
//                Button(action: {
//                    searchText = ""
//                    isSearching = false
//                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//                }) {
//                    Image(systemName: "xmark.circle.fill")
//                        .padding(.horizontal, 8)
//                        .foregroundColor(.gray)
//                }
//            }
//        }
//    }
//}
//
// 
//struct Friend: Identifiable {
//    let id = UUID()
//    var name: String
//    var personalityType: String
//}
//
//struct FriendsView: View {
//    @State var friendList: [String] = []
////    let currentUserID = "IRftJFGQ8EcFO0EAertjZVfLfKn1"
//    var currentUserID: String {
//        guard let uid = Auth.auth().currentUser?.uid else {
//            // Handle case where current user is not authenticated
//            return ""
//        }
//        return uid
//    }
////    @State private var friends = ["Alice", "Bob", "Charlie", "Dave"]
//    @State var searchText = ""
//    @State var isSearching = false
//    
//    var body: some View {
//        
//        VStack {
//            HStack {
////                VStack(alignment: .leading) {
////                    Text("friends")
////                        .font(.title)
////                }
//                Text("friends")
//                    .font(.title)
//                    .padding(.trailing, 200)
//                Circle()
//                    .frame(width: 30, height: 30)
//                    .foregroundColor(.blue) // Assuming all are online, for example
//            }
////            .padding(.bottom, 20)
//            .padding(.top, 10)
//            
//            Divider()
//                .background(Color(#colorLiteral(red: 0.0431372549, green: 0.1960784314, blue: 0.1568627451, alpha: 1))) // Set the background color of the divider
//                .frame(height: 10)
//            
//            SearchBar(searchText: $searchText, isSearching: $isSearching)
//                    .padding()
//            NavigationView {
//                    List(friendList, id: \.self) { friend in
//                        HStack {
//                            Circle()
//                                .frame(width: 30, height: 30)
//                                .foregroundColor(.green) // Assuming all are online, for example
//                            Text(friend)
//                                .font(.headline)
//                            Spacer()
//                        }
//                    }
//                    .navigationTitle("my friends (\(friendList.count))")
////                    .toolbar {
////                        Button(action: addFriend) {
////                            Image(systemName: "plus")
////                        }
////                    }
//            }
//        }
//        .onAppear {
//            Task {
//                print("Inside Task")
//                do {
//                    friendList = try await fetchFriends(userID: "IRftJFGQ8EcFO0EAertjZVfLfKn1")
//                } catch {
//                    print("Error fetching friends data: \(error)")
//                }
//                
//            }
//        }
//        
//    }
//
//    
//    
///////////////////////////////////////////////////////////////////////////////////////FUNCTIONS////////////////////////////////////////////////////////////////////////////////////////////////////////////
//    func fetchFriends(userID: String) async -> [String] {
//        var friendListName: [String] = []
////        var friendList: [String] = []
//        do {
//                // Fetch friend IDs
//                let friendIDs = try await fetchFriendsID(userID: userID)
//                
//                // Fetch names for each friend ID
//                let names = try await withThrowingTaskGroup(of: String.self) { group -> [String] in
//                    var names: [String] = []
//                    for friendID in friendIDs {
//                        group.addTask {
//                            do {
//                                let name = try await fetchUserName(userID: friendID)
//                                return name
//                            } catch {
//                                throw error
//                            }
//                        }
//                    }
//                    for try await nameResult in group {
//                        names.append(nameResult)
//                    }
//                    return names
//                }
//                
//                return names
//            } catch {
//                print("Error fetching friends' names: \(error.localizedDescription)")
//            }
//        
//        func fetchFriendsID(userID: String) async -> [String] {
//            var friendList: [String] = []
//            let db = Firestore.firestore()
//            let friendsCollection = db.collection("friends")
//            
//            do {
//                let friendsQuery = friendsCollection.whereField("primary", isEqualTo: userID)
//                let friendsSnapshot = try await friendsQuery.getDocuments()
//                
//                for document in friendsSnapshot.documents {
//                    if let friendID = document["secondary"] as? String {
//                        print("friendID: \(friendID)")
//                        friendList.append(friendID)
//                        
//                    }
//                }
//            } catch {
//                print("Error fetching friends: \(error.localizedDescription)")
//            }
//            return friendList
//        }
//        
//        func fetchUserName(userID: String) async throws -> String {
//            let db = Firestore.firestore()
//            let usersCollection = db.collection("users")
//            var name: String = ""
//            
//            do {
//                let userDoc = try await usersCollection.document(userID).getDocument()
//                if let userName = userDoc.data()?["name"] as? String {
//                    name = userName
//                }
//            } catch {
//                print("Error fetching user name: \(error.localizedDescription)")
//                throw error
//            }
//            return name
//        }
//        return friendListName
//    }
//    
//    func returnSearchFriend(searchedText: String) async -> [(name: String, id: String)] {
//        let db = Firestore.firestore()
//        let usersCollection = db.collection("users")
//        var users: [(name: String, id: String)] = []
//        
//        do {
//            // Construct a query to find users whose name contains the searched text
//            let querySnapshot = try await usersCollection.whereField("name", isGreaterThanOrEqualTo: searchedText)
//                                                         .whereField("name", isLessThan: searchedText + "\u{f8ff}")
//                                                         .getDocuments()
//            
//            // Iterate through the query results
//            for document in querySnapshot.documents {
//                let data = document.data()
//                if let name = data["name"] as? String, let id = data["id"] as? String {
//                    // Append the name and ID to the users array
//                    users.append((name: name, id: id))
//                }
//            }
//        } catch {
//            print("Error searching for users: \(error.localizedDescription)")
//        }
//        
//        return users
//    }
//    
//    func addFriend(userID: String) async throws {
//        let db = Firestore.firestore()
//        let friendsCollection = db.collection("friends")
//        let currentUserID = Auth.auth().currentUser!.uid
//        
//        // Check if a friendship document already exists with the given users
//        let existingFriendshipQuery = friendsCollection
//            .whereField("primary", isEqualTo: userID)
//            .whereField("secondary", isEqualTo: currentUserID)
//        
//        let existingFriendshipSnapshot = try await existingFriendshipQuery.getDocuments()
//        
//        if existingFriendshipSnapshot.documents.isEmpty {
//            // Friendship document doesn't exist, so add it
//            // Add friendship with "primary" field as the current user and "secondary" field as the provided userID
//            try await friendsCollection.addDocument(data: [
//                "primary": currentUserID,
//                "secondary": userID
//            ])
//            
//            // Add friendship with "primary" field as the provided userID and "secondary" field as the current user
//            try await friendsCollection.addDocument(data: [
//                "primary": userID,
//                "secondary": currentUserID
//            ])
//            
//            print("Friendship added successfully")
//        } else {
//            print("Friendship already exists")
//        }
//    }
//
//
//    /////////////////////////////////////////////////////////////////////////////////////FUNCTIONS////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//}
//
//#Preview {
//    FriendsView()
//}
