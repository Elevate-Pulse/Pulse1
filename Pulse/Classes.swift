//  classes.swift

import SwiftUI

extension Color {
    static let greenColor = Color(red: 35/255, green: 109/255, blue: 97/255)
}

class User: Identifiable, Codable {
    var id: String
    var name: String
    var email: String
    //var pfp: URL
    //var bookmarks: [Post]
    //var posts: [Post]
    init(id: String, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
        //self.pfp = pfp
        //self.bookmarks = bookmarks
        //self.posts = posts
    }
}

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
