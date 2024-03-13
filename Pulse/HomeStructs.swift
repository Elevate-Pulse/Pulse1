//  HomeStructs.swift
/*structs included:
-PfpName: user profile pic and name next to each other
 -PostBox_Main: what a post looks like
 -PostBox_Trending: what a trending post looks like
 -TagButton: a singular tag
 -AllTagButtons: every tag together in the horizontal scrollview
 -AIButton: Pulse Assistant button
 -InteractButtons: Combo of comments/sent/bookmark button
 -CommentButton
 -SentButton
 -BookmarkButton
 */

import SwiftUI

struct PfpName: View {
    let name: String
    let fontSize: CGFloat
    var body: some View {
            HStack(spacing: 1) {
                Circle()
                    .frame(width: 30)
                    .padding(.horizontal, 8)
                    .foregroundColor(Color.black)
                Text(name)
                    .foregroundColor(Color.black)
                    .font(.custom("Poppins-Light", size: fontSize))
            }
        }
    }

struct PostBox_Main: View {
    let name: String
    let date: String
    let bodyText: String
    let commentCount: Int
    let sentCount: Int
    let bookmarkCount: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                PfpName(name: name, fontSize: 21)
                Spacer()
                HStack {
                    Spacer()
                    Text(date)
                        .font(.custom("Poppins-Light", size: 15))
                        .foregroundColor(Color(UIColor.darkGray))
                        .padding(.trailing, 10)
                }
            }

            
            Text(bodyText)
                .lineLimit(3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .font(.custom("Poppins-Light", size: 18))

            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: -5) {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: UIScreen.main.bounds.width / 2 - 25, height: 200)
                        .foregroundColor(Color.red)
                        .padding(.horizontal, 10)
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: UIScreen.main.bounds.width / 2 - 25, height: 200)
                        .foregroundColor(Color.blue)
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: UIScreen.main.bounds.width / 2 - 25, height: 200)
                        .foregroundColor(Color.yellow)
                        .padding(.horizontal, 10)
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: UIScreen.main.bounds.width / 2 - 25, height: 200)
                        .foregroundColor(Color.green)
                }
            }
            AIButton()
                .padding(.leading, UIScreen.main.bounds.width - 190)
            InteractButtons(commentCount: commentCount, sentCount: sentCount, bookmarkCount: bookmarkCount)
            Divider()
        }
    }
}

struct PostBox_Trending: View {
    let height: CGFloat
    let color: Color
    let bodyText: String
    let name: String
    let fontSize: CGFloat
    var body: some View {
        Button(action: {
            print("Post tapped on")
        }) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(color, lineWidth: 2)
                    .frame(width: 225, height: height)
                    .layoutPriority(1)
                VStack(alignment: .leading, spacing: 1) {
                    PfpName(name: name, fontSize: fontSize)
                        .padding(.vertical, 6)
                    Text(bodyText)
                        .font(.custom("Poppins-Light", size: 16))
                        .padding([.vertical, .horizontal], 8)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                }
            }
        }
        .foregroundColor(Color.black)
    }
}

struct TagButton: View {
    let tag: String
    @State private var isSelected: Bool = false
    
    var body: some View {
        Button(action: {
            isSelected.toggle()
            print("tag button tapped")
        }) {
            Text(tag)
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color(UIColor.darkGray), lineWidth: 3)
                        .background(isSelected ? Color(UIColor.darkGray) : Color.clear)
                        .cornerRadius(50)
                )
                .foregroundColor(isSelected ? Color.white : Color(UIColor.darkGray))
                .font(.custom("Poppins-Light", size: 16))
        }
        .animation(.default, value: isSelected)
    }
}

struct AllTagButtons: View {
    var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    TagButton(tag: "#communityhealth")
                    TagButton(tag: "#crime")
                    TagButton(tag: "#event")
                    TagButton(tag: "#homelessness")
                    TagButton(tag: "#infrastructure")
                    TagButton(tag: "#noisepullution")
                    TagButton(tag: "#pothole")
                    TagButton(tag: "#publicspaces")
                    TagButton(tag: "#safety")
                    TagButton(tag: "#education")
                    TagButton(tag: "#shooting")
                    TagButton(tag: "#transportation")
                }
                .padding(.horizontal, 10)
            }
    }
}

struct AIButton: View {
    @State private var showPHQV = false
    var body: some View {
        Button(action: {
            print("AI generator tapped")
            
            showPHQV = true
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 50).stroke(Color(UIColor.darkGray), lineWidth: 2)
                    .frame(width: 175, height: 40)
                HStack {
                    Image(systemName: "bolt.heart")
                        .foregroundColor(Color.black)
                    Text("Pulse Assistant")
                        .foregroundColor(Color(UIColor.darkGray))
                        .font(.custom("Poppins-Light", size: 16))
                }
            }
        }
        .sheet(isPresented: $showPHQV) {
            PulseHelperQuestionnaireView()
        }
    }
}

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
                    .font(.custom("Poppins-Light", size: 18))
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
                    .font(.custom("Poppins-Light", size: 18))
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
                    .font(.custom("Poppins-Light", size: 18))
            }
        }
    }
}


struct HomeStructs_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PfpName(name: "first last", fontSize: 21)
            Divider()
            PostBox_Main(name: "danny yao", date: "Feb 26th, 2024", bodyText: "First LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst Last Last Last", commentCount: 1, sentCount: 2, bookmarkCount: 3)
            Divider()
            PostBox_Trending(height: 150, color: .red, bodyText: "abc def gh ijk l mn opq rst uv wx yz......................dsdsdsdsdsdsdsdsddsds..........", name: "first last", fontSize: 21)
            Divider()
            TagButton(tag: "#lol")
            Divider()
            AllTagButtons()
            Divider()
            AIButton()
            Divider()
            InteractButtons(commentCount: 23, sentCount: 223, bookmarkCount: 32)
        }
    }
}
