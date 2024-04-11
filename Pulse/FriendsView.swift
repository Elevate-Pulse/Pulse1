////
//// FriendsView.swift
//// Pulse
////
//// Created by Litao Li on 4/8/24.
////
//import SwiftUI
//import FirebaseFirestore
//import Firebase
// 
//struct SearchBar: View {
//  @Binding var searchText: String
//  @Binding var isSearching: Bool
//  var body: some View {
//    HStack {
//      TextField("Search for friends", text: $searchText)
//        .autocorrectionDisabled()
//        .autocapitalization(.none)
//        .padding(.leading, 24)
//        .padding(.vertical, 8)
//        .background(Color(.systemGray6))
//        .cornerRadius(15)
//        .overlay(
//          RoundedRectangle(cornerRadius: 15)
//            .stroke(.black, lineWidth: 1)
//        )
//        .padding(.horizontal)
//        .padding(.bottom)
//        .onTapGesture {
//          isSearching = true
//        }
//      if isSearching {
//        Button(action: {
//          searchText = ""
//          isSearching = false
//          UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//        }) {
//          Image(systemName: "xmark.circle.fill")
//            .padding(.trailing, 24)
//            .foregroundColor(.gray)
//        }
//      }
//    }
//    .padding(.top)
//  }
//}
// 
//struct FriendsView: View {
//    @State private var friends: [(name: String, id: String, color: Color)] = [
//        //    Friend(name: "Maya"/*, personalityType: "Type A"*/, color: .purple),
//        //    Friend(name: "Litao"/*, personalityType: "Type B"*/, color: .pink),
//        //    Friend(name: "Yinglin"/*, personalityType: "Type C"*/, color: .green),
//        //    Friend(name: "Peter"/*, personalityType: "Type D"*/, color: .blue),
//        //    Friend(name: "Diana"/*, personalityType: "Type E"*/, color: .yellow)
//    ]
//    
//    @State var searchText = ""
//    @State var isSearching = false
//    @State private var searchResults: [(name: String, id: String)] = []
//    @State private var expandedFriendID: UUID?
//    let friendsFns = FriendsFns()
//    func searchFriends() async {
//        if !searchText.isEmpty {
//            do {
//                // Call the search function and update the searchResults state
//                searchResults = try await friendsFns.returnSearchFriend(searchedText: searchText)
//            }
//        } else {
//            // Clear search results if the search text is empty
//            searchResults = []
//        }
//    }
//    var body: some View {
//        ScrollView {
//            VStack {
//                Text("Friends")
//                    .font(Font.custom("Comfortaa-Light", size: 20))
//                    .padding(.leading)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                SearchBar(searchText: $searchText, isSearching: $isSearching)
//                    .onChange(of: searchText) { _ in
//                        Task {
//                            await searchFriends()
//                        }
//                    }
//                VStack(alignment: .leading, spacing: 10) {
//                    ForEach(searchResults, id: \.id) { result in
//                        HStack{
//                            Circle()
//                                .frame(width: 30, height: 30)
//                                .foregroundColor(friends.first { $0.name == result.name }?.color ?? Color.gray)
//                            Text(result.name)
//                                .font(Font.custom("Comfortaa-Light", size: 15))
//                                .foregroundStyle(Color.black)
//                            Spacer()
//                            Button(action: {
//                                Task {
//                                    try await friendsFns.addFriend(userID: result.id)
//                                }
//                            }) {
//                                Image(systemName: "plus.circle")
//                                    .foregroundColor(.blue)
//                            }
//                        }
//                        .padding()
//                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 0.5))
//                    }
//                    .padding()
//                }
//                VStack(alignment: .leading, spacing: 10) {
//                    ForEach(friends, id: \.id) { friend in
//                        //            NavigationLink(destination: Text(friend.name)) {
//                        HStack {
//                            Circle()
//                                .frame(width: 30, height: 30)
//                                .foregroundColor(friend.color)
//                            Text(friend.name)
//                                .font(Font.custom("Comfortaa-Light", size: 15))
//                                .foregroundStyle(Color.black)
//                            Spacer()
//                            Button(action: {
//                                withAnimation {
//                                    // Toggle the dropdown open/close for the tapped friend
//                                    self.expandedFriendID = (self.expandedFriendID == friend.id) ? nil : friend.id
//                                }
//                            }){
//                                Image(systemName: "chevron.right")
//                                    .rotationEffect(.degrees(self.expandedFriendID == friend.id ? 90 : 0))
//                                    .animation(.easeInOut, value: self.expandedFriendID == friend.id)
//                            }
//                        }
//                        .padding()
//                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 0.5))
//                        .padding(.horizontal)
//                        
//                        if self.expandedFriendID == friend.id {
//                            // Embedding the Circles view statically within a bordered rectangle
//                            ZStack {
//                                // Border rectangle
//                                RoundedRectangle(cornerRadius: 16)
//                                    .stroke(Color.black, lineWidth: 2) // Border with a black stroke
//                                    .frame(width: 375, height: 300) // Set your desired width and height
//                                    .background(Color("cream")) // Set the background color inside the border
//                                
//                                // Circles view
//                                Circles()
//                                //                                    .padding() // Padding inside the circles view
//                            }
//                            // Specify the frame for the ZStack if you want to limit its size
//                            .frame(width: 400, height: 300, alignment: .center)
//                            // Eliminate the transition to make it appear statically
//                        }
//                        //            }
//                    }
//                }
//                //        .padding()
//            }
//        }
//        .background(Color("cream"))
//        .onAppear {
//            Task {
//                //          await fetchFriends(userID: Auth.auth().currentUser?.uid)
//                friends = await friendsFns.fetchFriends(userID: Auth.auth().currentUser!.uid)
//            }
//        }
//        .onChange(of: searchText) { _ in
//            // Triggered when friends list changes (i.e., when a friend is added)
//            Task {
//                friends = await friendsFns.fetchFriends(userID: Auth.auth().currentUser!.uid)
//            }
//        }
//        
//        
//    }
//}
//    #Preview {
//      FriendsView()
//    }
