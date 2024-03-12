import SwiftUI

struct CommentsView: View {
    let name: String
    let date: String
    @State private var isTextExpanded = false
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGray5)
                .ignoresSafeArea()
            VStack {
                HStack(spacing: -20) {
                    Button(action: {
                        print("Going back")
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color(UIColor.systemGray))
                    }
                    .padding()
                    Text("Comments")
                        .font(.custom("Poppins-Medium", size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        PostBox_Main(name: "danny yao", date: "Feb 26th, 2024", bodyText: "short test", commentCount: 4, sentCount: 5, bookmarkCount: 6) //find in structs_postBox
                        aComment(name: "zack zach", date: "Feb 28th, 2022", numReplies: 100) //find in structs_postBox
                    }
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    CommentsView(name: "danny yao2", date: "Feb 25th, 2024")
}
