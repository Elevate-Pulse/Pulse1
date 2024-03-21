//  classes.swift

import SwiftUI

extension Color {
    static let greenColor = Color(red: 35/255, green: 109/255, blue: 97/255)
}

class User: Identifiable {
    var id: UUID
    var name: String
    var pfp: URL
    //var bookmarks: [Post]
    //var posts: [Post]
    init(name: String, pfp: URL) {
        self.id = UUID()
        self.name = name
        self.pfp = pfp
        //self.bookmarks = bookmarks
        //self.posts = posts
    }
    
    func getName() -> String {
        return name
    }
}

let userProfilePic = Image(systemName: "person.fill")
let user1 = User(name: "Peter Guan", pfp: URL(string: "https://pbs.twimg.com/profile_images/1592590631683198977/Ouiq1uCA_400x400.jpg")!)

class Post {
    var user: User
    var date: String
    var bodyText: String
    var media: [Image]
    var tags: [Tag]
    var numComments: Int
    var numSends: Int
    var numBookmarks: Int
    var numMad: Int
    var numSurprised: Int
    var numHappy: Int
    var numSad: Int
    var numAnnoyed: Int
    var numCongrats: Int
    
    init(user: User, date: String, bodyText: String, media: [Image], tags: [Tag],
         numComments: Int = 0, numSends: Int = 0, numBookmarks: Int = 0,
         numMad: Int = 0, numSurprised: Int = 0, numHappy: Int = 0,
         numSad: Int = 0, numAnnoyed: Int = 0, numCongrats: Int = 0) {
        self.user = user
        self.date = date
        self.bodyText = bodyText
        self.media = media
        self.tags = tags
        self.numComments = numComments
        self.numSends = numSends
        self.numBookmarks = numBookmarks
        self.numMad = numMad
        self.numSurprised = numSurprised
        self.numHappy = numHappy
        self.numSad = numSad
        self.numAnnoyed = numAnnoyed
        self.numCongrats = numCongrats
    }
}

class Tag {
    var tag: String
    init(tag: String) {
        self.tag = tag
    }
}


struct Classes: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    Classes()
}
