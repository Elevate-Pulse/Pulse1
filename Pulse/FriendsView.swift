import Firebase
import FirebaseFirestore
import FirebaseAuth

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
    let currentUserID = Auth.auth().currentUser!.uid
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
  }
