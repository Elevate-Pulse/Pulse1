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
        .padding(.bottom)
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
 
import SwiftUI
import FirebaseFirestore
import Firebase

struct FriendsView: View {
    @State private var friends: [(name: String, id: String, color: Color)] = []
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var searchResults: [(name: String, id: String)] = []
    @State private var expandedFriendID: String?
    let friendsFns = FriendsFns()
    @State private var shouldLoadFriends = false
    @State private var shouldLoadSearchResults = false
    
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
                    if shouldLoadSearchResults {
                        ForEach(searchResults, id: \.id) { result in
                            HStack{
                                Circle()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(friends.first { $0.name == result.name }?.color ?? Color.gray)
                                Text(result.name)
                                    .font(Font.custom("Comfortaa-Light", size: 15))
                                    .foregroundStyle(Color.black)
                                Spacer()
                                Button(action: {
                                    Task {
                                        do {
                                            // Try to add the friend
                                            try await friendsFns.addFriend(userID: result.id)
                                            // If successfully added, reload the friends list
                                            await loadFriends()
                                        } catch {
                                            // Handle error if adding friend fails
                                            print("Failed to add friend: \(error)")
                                        }
                                    }
                                }) {
                                    Image(systemName: "plus.circle")
                                        .foregroundColor(Color(red: 35/255, green: 109/255, blue: 97/255))
                                }
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 0.5))
                        }
                        .padding()
                    }
                }
                 
                VStack(alignment: .leading, spacing: 10) {
                    if shouldLoadFriends {
                        ForEach(friends, id: \.id) { friend in
                            HStack {
                                Circle()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(friend.color)
                                Text(friend.name)
                                    .font(Font.custom("Comfortaa-Light", size: 15))
                                    .foregroundStyle(Color.black)
                                Spacer()
                                Button(action: {
                                    withAnimation {
                                        self.expandedFriendID = (self.expandedFriendID == friend.id) ? nil : friend.id
                                    }
                                }){
                                    Image(systemName: "chevron.right")
                                        .rotationEffect(.degrees(self.expandedFriendID == friend.id ? 90 : 0))
                                        .animation(.easeInOut, value: self.expandedFriendID == friend.id)
                                        .foregroundColor(Color(red: 35/255, green: 109/255, blue: 97/255))
                                }
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 0.5))
                            .padding(.horizontal)
                            
                            if self.expandedFriendID == friend.id {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.black, lineWidth: 2)
                                        .frame(width: 375, height: 300)
                                        .background(Color("cream"))
                                    Circles()
                                }
                                .frame(width: 400, height: 300, alignment: .center)
                            }
                        }
                    }
                }
                
            }
        }
        .background(Color("cream"))
        .onAppear {
            Task {
                await loadFriends()
                shouldLoadFriends = true
            }
        }
        .onChange(of: searchText) { _ in
            Task {
                await searchFriends()
                shouldLoadSearchResults = true
            }
        }
    }
    
    func loadFriends() async {
        friends = await friendsFns.fetchFriends(userID: Auth.auth().currentUser!.uid)
    }
    
    func searchFriends() async {
        if !searchText.isEmpty {
            do {
                searchResults = try await friendsFns.returnSearchFriend(searchedText: searchText)
            }
        } else {
            searchResults = []
        }
    }
}

    #Preview {
      FriendsView()
    }
