////
////  FriendsFns.swift
////  Pulse
////
////  Created by Peter Guan on 4/11/24.
////
//
//import SwiftUI
//import FirebaseFirestore
//import FirebaseAuth
//
//struct FriendsFns: View {
//    func returnSearchFriend(searchedText: String) async -> [(name: String, id: String)] {
//      let db = Firestore.firestore()
//      let usersCollection = db.collection("users")
//      var users: [(name: String, id: String)] = []
//      do {
//       // Construct a query to find users whose name contains the searched text
//       let querySnapshot = try await usersCollection.whereField("name", isGreaterThanOrEqualTo: searchedText)
//          .whereField("name", isLessThan: searchedText + "\u{f8ff}")
//                   .getDocuments()
//       // Iterate through the query results
//       for document in querySnapshot.documents {
//        let data = document.data()
//        if let name = data["name"] as? String, let id = data["id"] as? String {
//         // Append the name and ID to the users array
//         users.append((name: name, id: id))
//        }
//       }
//      } catch {
//       print("Error searching for users: \(error.localizedDescription)")
//      }
//      return users
//     }
//   
//     func addFriend(userID: String) async throws {
//      let db = Firestore.firestore()
//      let friendsCollection = db.collection("friends")
//      let currentUserID = Auth.auth().currentUser?.uid ?? "exampleID"
//      // Check if a friendship document already exists with the given users
//      let existingFriendshipQuery = friendsCollection
//       .whereField("primary", isEqualTo: userID)
//       .whereField("secondary", isEqualTo: currentUserID)
//      let existingFriendshipSnapshot = try await existingFriendshipQuery.getDocuments()
//      if existingFriendshipSnapshot.documents.isEmpty {
//       // Friendship document doesn't exist, so add it
//       // Add friendship with "primary" field as the current user and "secondary" field as the provided userID
//       try await friendsCollection.addDocument(data: [
//        "primary": currentUserID,
//        "secondary": userID
//       ])
//       // Add friendship with "primary" field as the provided userID and "secondary" field as the current user
//       try await friendsCollection.addDocument(data: [
//        "primary": userID,
//        "secondary": currentUserID
//       ])
//       print("Friendship added successfully")
//      } else {
//       print("Friendship already exists")
//      }
//  //     await loadFriends()
//     }
//   
//      func fetchFriends(userID: String) async -> [(name: String, id: String, color: Color)] {
//        var friends: [(name: String, id: String, color: Color)] = []
//    //    var friendList: [String] = []
//        do {
//            // Fetch friend IDs
//            let friendIDs = try await fetchFriendsID(userID: userID)
//            // Fetch names for each friend ID
//            let friendDetails = try await withThrowingTaskGroup(of: (String, Color).self) { group -> [(String, Color)] in
//              var details: [(String, Color)] = []
//              for friendID in friendIDs {
//                group.addTask {
//                  do {
//                    let name = try await fetchUserName(userID: friendID)
//                      let personalityTypeColor = await fetchUserPersonalityTypeColor(userID: friendID)
//                      return (name, personalityTypeColor)
//                  } catch {
//                    throw error
//                  }
//                }
//              }
//                for try await friendDetailResult in group {
//                    details.append(friendDetailResult)
//                }
//   
//                return details
//            }
//   
//            for (name, color) in friendDetails {
//                friends.append((name: name, id: friendIDs[friends.count], color: color))
//            }
//          } catch {
//            print("Error fetching friends' names: \(error.localizedDescription)")
//          }
//   
//        func fetchFriendsID(userID: String) async -> [String] {
//          var friendList: [String] = []
//          let db = Firestore.firestore()
//          let friendsCollection = db.collection("friends")
//          do {
//            let friendsQuery = friendsCollection.whereField("primary", isEqualTo: userID)
//            let friendsSnapshot = try await friendsQuery.getDocuments()
//            for document in friendsSnapshot.documents {
//              if let friendID = document["secondary"] as? String {
//                print("friendID: \(friendID)")
//                friendList.append(friendID)
//              }
//            }
//          } catch {
//            print("Error fetching friends: \(error.localizedDescription)")
//          }
//          return friendList
//        }
//        func fetchUserName(userID: String) async throws -> String {
//          let db = Firestore.firestore()
//          let usersCollection = db.collection("users")
//          var name: String = ""
//          do {
//            let userDoc = try await usersCollection.document(userID).getDocument()
//            if let userName = userDoc.data()?["name"] as? String {
//              name = userName
//   
//            }
//          } catch {
//            print("Error fetching user name: \(error.localizedDescription)")
//            throw error
//          }
//            print("Name: \(name)")
//          return name
//        }
//        return friends
//      }
//   
//      func fetchUserPersonalityTypeColor(userID: String) async -> Color {
//          let db = Firestore.firestore()
//          let surveyResponsesCollection = db.collection("survey_responses")
//          var personalityType: String = ""
//   
//          do {
//              // Construct a query to get the document with the matching userID
//              let querySnapshot = try await surveyResponsesCollection.whereField("userID", isEqualTo: userID).getDocuments()
//   
//              // Check if the query returned any documents
//              guard let document = querySnapshot.documents.first else {
//                  print("No document found for userID: \(userID)")
//                  // Handle the case where no document is found (return default color or handle differently)
//                  return .gray // Return a default color
//              }
//   
//              // Retrieve the personalityType from the document
//              if let personality = document.data()["personalityType"] as? String {
//                  personalityType = personality
//                  print("Personality Type: \(personalityType)")
//              } else {
//                  print("Personality type not found in document")
//                  // Handle the case where personalityType is not found in the document
//                  return .gray // Return a default color
//              }
//          } catch {
//              print("Error fetching user personality type: \(error.localizedDescription)")
//              // Handle the error (return default color or handle differently)
//              return .gray // Return a default color
//          }
//   
//          // Determine and return the color based on the personality type
//          return colorForType(type: personalityType)
//      }
//   
//   
//      private func colorForType(type: String) -> Color {
//          switch type {
//          case "Outgoing Spirit":
//              return Color("yellow_c")
//          case "Open-Minded Explorer":
//              return Color("peach") // Ensure this color is defined in your asset catalog or use a SwiftUI color approximation
//          case "Private Resident":
//              return Color("light_green") // Define this color too
//          case "Engaged Citizen":
//              return Color("purple_c")
//          case "Easygoing Neighbor":
//              return Color("blue_c")
//          default:
//              return Color.gray // Fallback color
//          }
//      }
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//#Preview {
//    FriendsFns()
//}
