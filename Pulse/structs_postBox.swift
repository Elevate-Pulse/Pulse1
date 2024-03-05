//  structs_postBox.swift


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
                    .font(.system(size: CGFloat(fontSize)))
            }
        }
    }


struct PostBox_Main: View {
    let name: String
    let date: String
    let commentCount: Int
    let sentCount: Int
    let bookmarkCount: Int
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 1) {
                PfpName(name: name, fontSize: 21)
                HStack {
                    Text(date)
                        .font(.system(size: 15))
                        .foregroundColor(Color(UIColor.systemGray))
                }
                .padding(.leading, 135)
            }
            
            Text("First LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst Last Last Last")
                .padding(.horizontal, 12)
                .lineLimit(3)
                .truncationMode(.tail)
            HStack(spacing: 15) {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: UIScreen.main.bounds.width / 2 - 25, height: 200)
                    .foregroundColor(Color.red)
                    .padding(.horizontal, 10)
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: UIScreen.main.bounds.width / 2 - 25, height: 200)
                    .foregroundColor(Color.blue)
                    .padding(.leading, -5)
            }
            AIButton()
            InteractButtons(commentCount: commentCount, sentCount: sentCount, bookmarkCount: bookmarkCount)
            Divider()
        }
    }
}

struct PostBox_Trending: View {
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
                        .padding(.vertical, 8)
                    Text("abc def gh ijk l mn opq rst uv wx yz................................")
                        .padding([.vertical, .horizontal], 8)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading) 
                }
            }
            .padding(8)
        }
        .foregroundColor(Color.black)
    }
}

struct structs_postBox_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PfpName(name: "first last", fontSize: 21)
            Divider()
            PostBox_Main(name: "danny yao", date: "Feb 26th, 2024", commentCount: 1, sentCount: 2, bookmarkCount: 3)
            Divider()
            PostBox_Trending(name: "first last", fontSize: 21)
            Divider()
        }
    }
}
