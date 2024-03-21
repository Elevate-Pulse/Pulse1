//  CommentsStructs.swift
/*structs included:
-aComment: what a comment looks like
 */
// Look at HomeStructs for struct PostBox_Main

import SwiftUI

struct aComment: View {
    let name: String
    let date: String
    let numReplies: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                PfpName(name: name, fontSize: 21)
                    .padding(.horizontal, 15)
                Spacer()
                HStack {
                    Spacer()
                    Text(date)
                        .font(.custom("Poppins-Light", size: 15))
                        .foregroundColor(Color(UIColor.darkGray))
                        .padding(.trailing, 24)
                }
            }

            
            Text("First LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst LastFirst Last Last Last")
                .lineLimit(3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .font(.custom("Poppins-Light", size: 16))
            Button(action: {
                print("Replies tapped on")
            }) {
                Text("\(numReplies) \(numReplies == 1 ? "reply" : "replies")")
                    .font(.custom("Poppins-Light", size: 16))
                    .foregroundColor(Color(UIColor.darkGray))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
            }
            Divider()
        }
    }
}


struct Comments_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            aComment(name: "Peter Guan", date: "Apr 14th, 1999", numReplies: 999)
            Divider()
        }
    }
}
