//  structs_postInteractions.swift
/*
 structs included:
-InteractButtons: comments, sent, bookmark buttons combined
-CommentButton: how many ppl commented on this post
-SentButton: how many ppl used this post to write email
-BookmarkButton: how many ppl bookmarked the post
 */

import SwiftUI

struct InteractButtons: View {
    let commentCount: Int
    let sentCount: Int
    let bookmarkCount: Int
    var body: some View {
        Button(action: {
            print("Comments tapped")
        }) {
            HStack {
                CommentButton(commentCount: commentCount)
                SentButton(sentCount: sentCount)
                BookmarkButton(bookmarkCount: bookmarkCount)
            }
            .padding(.horizontal, 15)

        }
        .accentColor(Color(UIColor.darkGray))
    }
}

struct CommentButton: View {
    let commentCount: Int
    var body: some View {
        Button(action: {
            print("Comments tapped")
        }) {
            HStack {
                Image(systemName: "message")
                    .imageScale(.large)
                Text(String(commentCount))
                    .font(.custom("Poppins-Medium", size: 18))
            }
        }
    }
}

struct SentButton: View {
    let sentCount: Int
    var body: some View {
        Button(action: {
            print("Sent mail tapped")
        }) {
            HStack {
                Image(systemName: "paperplane")
                    .imageScale(.large)
                Text(String(sentCount))
                    .font(.custom("Poppins-Medium", size: 18))
            }
        }
    }
}

struct BookmarkButton: View {
    let bookmarkCount: Int
    var body: some View {
        Button(action: {
            print("Bookmarks tapped")
        }) {
            HStack {
                Image(systemName: "bookmark")
                    .imageScale(.large)
                Text(String(bookmarkCount))
                    .font(.custom("Poppins-Medium", size: 18))
            }
        }
    }
}

struct structs_postInteractions_Previews: PreviewProvider {
    static var previews: some View {
            InteractButtons(commentCount: 1, sentCount: 2, bookmarkCount: 3)
    }
}
