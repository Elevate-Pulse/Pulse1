//
//  classes.swift
//  Pulse
//
//  Created by student on 3/12/24.
//

import SwiftUI

class User {
    var name: String
    var pfp: Image
    //var bookmarks: [Post]
    init(name: String, pfp: Image) {
        self.name = name
        self.pfp = pfp
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


struct classes: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    classes()
}
