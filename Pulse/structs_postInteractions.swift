//  structs_postInteractions.swift

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
                Text(String(commentCount))
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
                Text(String(sentCount))
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
                Text(String(bookmarkCount))
            }
        }
    }
}

struct structs_postInteractions_Previews: PreviewProvider {
    static var previews: some View {
            InteractButtons(commentCount: 1, sentCount: 2, bookmarkCount: 3)
    }
}
