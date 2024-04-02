//  HomeStructs.swift
/*structs included:
-PfpName: user profile pic and name next to each other
 -PostBox_Main: what a post looks like
 -PostBox_Trending: what a trending post looks like
 -TagButton: a singular tag
 -AllTagButtons: every tag together in the horizontal scrollview
 -AIButton: Pulse Assistant button
 -ReactionButtons: Emoji reactions
 -ReactionButtonHelper
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
            ReactionButtons()
                .padding(.horizontal, 10)
                .padding(.vertical, 8)
            HStack {
                InteractButtons(commentCount: commentCount, sentCount: sentCount, bookmarkCount: bookmarkCount)
                Spacer()
                AIButton()
                    .padding(.trailing, 10)
            }
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
    @Binding var selectedTags: Set<String>
    
    var body: some View {
        Button(action: {
            if selectedTags.contains(tag) {
                selectedTags.remove(tag)
            } else {
                selectedTags.insert(tag)
            }
            print("tag button tapped")
        }) {
            Text(tag)
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color(UIColor.darkGray), lineWidth: 3)
                        .background(selectedTags.contains(tag) ? Color(UIColor.darkGray) : Color.clear)
                        .cornerRadius(50)
                )
                .foregroundColor(selectedTags.contains(tag) ? Color.white : Color(UIColor.darkGray))
                .font(.custom("Poppins-Light", size: 16))
        }
    }
}

struct AllTagButtons: View {
    @State private var selectedTags: Set<String> = []

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: -15) {
                ForEach(tags, id: \.self) { tag in
                    TagButton(tag: tag, selectedTags: $selectedTags)
                }
                .padding(.horizontal, 10)
            }
        }
    }

    let tags = ["#communityhealth", "#crime", "#event", "#homelessness", "#infrastructure", "#noisepullution", "#pothole", "#publicspaces", "#safety", "#education", "#shooting", "#transportation"]
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
                    .frame(width: 175, height: 35)
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

struct ReactionButtons: View {
    @State private var happyCount: Int = 0
    @State private var congratsCount: Int = 0
    @State private var surprisedCount: Int = 0
    @State private var annoyedCount: Int = 0
    @State private var sadCount: Int = 0
    @State private var madCount: Int = 0
    @State private var selectedReactions: Set<String> = []

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ReactionButtonHelper(icon: "😄", count: happyCount, reaction: "Happy", isSelected: selectedReactions.contains("Happy")) {
                    toggleReaction("Happy")
                }
                ReactionButtonHelper(icon: "🙌", count: congratsCount, reaction: "Congrats", isSelected: selectedReactions.contains("Congrats")) {
                    toggleReaction("Congrats")
                }
                ReactionButtonHelper(icon: "😱", count: surprisedCount, reaction: "Surprised", isSelected: selectedReactions.contains("Surprised")) {
                    toggleReaction("Surprised")
                }
                ReactionButtonHelper(icon: "😒", count: annoyedCount, reaction: "Annoyed", isSelected: selectedReactions.contains("Annoyed")) {
                    toggleReaction("Annoyed")
                }
                ReactionButtonHelper(icon: "😢", count: sadCount, reaction: "Sad", isSelected: selectedReactions.contains("Sad")) {
                    toggleReaction("Sad")
                }
                ReactionButtonHelper(icon: "😡", count: madCount, reaction: "Mad", isSelected: selectedReactions.contains("Mad")) {
                    toggleReaction("Mad")
                }
            }
        }
    }

    private func toggleReaction(_ reaction: String) {
        if selectedReactions.contains(reaction) {
            selectedReactions.remove(reaction)
            decrementCount(for: reaction)
        } else {
            selectedReactions.insert(reaction)
            incrementCount(for: reaction)
        }

        print("\(reaction) reaction toggled")
    }

    private func incrementCount(for reaction: String) {
        switch reaction {
            case "Happy":
                happyCount += 1
            case "Congrats":
                congratsCount += 1
            case "Surprised":
                surprisedCount += 1
            case "Annoyed":
                annoyedCount += 1
            case "Sad":
                sadCount += 1
            case "Mad":
                madCount += 1
            default:
                break
        }
    }

    private func decrementCount(for reaction: String) {
        switch reaction {
            case "Happy":
                happyCount -= 1
            case "Congrats":
                congratsCount -= 1
            case "Surprised":
                surprisedCount -= 1
            case "Annoyed":
                annoyedCount -= 1
            case "Sad":
                sadCount -= 1
            case "Mad":
                madCount -= 1
            default:
                break
        }
    }
}

struct ReactionButtonHelper: View {
    let icon: String
    let count: Int
    let reaction: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 50)
                    .strokeBorder(Color(UIColor.darkGray), lineWidth: 1)
                    .background(RoundedRectangle(cornerRadius: 50).fill(isSelected ? Color(UIColor.darkGray) : Color.clear))
                    .frame(width: 55, height: 30)
                Text("\(icon) \(count)")
                    .foregroundColor(isSelected ? .white : Color(UIColor.darkGray))
                    .font(.custom("Poppins-Light", size: 16))
            }
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
    @State private var openComments = false
    let commentCount: Int
    var body: some View {
        Button(action: {
            print("Comments tapped")
            openComments = true
        }) {
            HStack {
                Image(systemName: "message")
                    .imageScale(.large)
                Text(String(commentCount))
                    .font(.custom("Poppins-Light", size: 18))
            }
        }
        .sheet(isPresented: $openComments) {
            CommentsView(name: "danny yao2", date: "Feb 25th, 2024")
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
             /*
            Divider()
            TagButton(tag: "#lol")
            Divider()
            AllTagButtons()
            Divider()
            AIButton()
            Divider()
              */
            InteractButtons(commentCount: 23, sentCount: 223, bookmarkCount: 32)
            Divider()
            ReactionButtons()
        }
    }
}
