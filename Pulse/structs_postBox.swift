//  structs_postBox.swift
/*
 structs included:
 -PfpName: profile pic next to name
 -PostBox_Main: what a singular post looks like
 -PostBox_Trending: what a trending post looks like
 -aComment: what a comment looks like
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
                    .font(.custom("Poppins-Medium", size: fontSize))
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
                        .font(.custom("Poppins-Medium", size: 15))
                        .foregroundColor(Color(UIColor.darkGray))
                        .padding(.trailing, 10)
                }
            }

            
            Text(bodyText)
                .lineLimit(3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .font(.custom("Poppins-Medium", size: 18))

            
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
    let bodyText: String
    let name: String
    let fontSize: CGFloat
    var body: some View {
        Button(action: {
            print("Post tapped on")
        }) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.red, lineWidth: 2)
                    .frame(width: 225, height: 150)
                    .layoutPriority(1)
                    .foregroundColor(.red)
                VStack(alignment: .leading, spacing: 1) {
                    PfpName(name: name, fontSize: fontSize)
                        .padding(.vertical, 6)
                    Text(bodyText)
                        .font(.custom("Poppins-Medium", size: 16))
                        .padding([.vertical, .horizontal], 8)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                }
            }
        }
        .foregroundColor(Color.black)
    }
}

struct aComment: View {
    let name: String
    let date: String
    let numReplies: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                PfpName(name: name, fontSize: 21)
                Spacer()
                HStack {
                    Spacer()
                    Text(date)
                        .font(.custom("Poppins-Medium", size: 15))
                        .foregroundColor(Color(UIColor.darkGray))
                        .padding(.trailing, 10)
                }
            }

            
            Text("First LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst Last Last Last")
                .lineLimit(3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .font(.custom("Poppins-Medium", size: 16))
            Button(action: {
                print("Replies tapped on")
            }) {
                Text("\(numReplies) \(numReplies == 1 ? "reply" : "replies")")
                    .font(.custom("Poppins-Medium", size: 16))
                    .foregroundColor(Color(UIColor.darkGray))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
            }
            Divider()
        }
    }
}

struct structs_postBox_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PfpName(name: "first last", fontSize: 21)
            Divider()
            PostBox_Main(name: "danny yao", date: "Feb 26th, 2024", bodyText: "First LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst Last Last Last", commentCount: 1, sentCount: 2, bookmarkCount: 3)
            Divider()
            PostBox_Trending(bodyText: "abc def gh ijk l mn opq rst uv wx yz......................dsdsdsdsdsdsdsdsddsds..........", name: "first last", fontSize: 21)
            Divider()
            aComment(name: "bob bob", date: "Feb 299th, 2024", numReplies: 10)
        }
    }
}
