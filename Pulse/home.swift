//home.swift

import SwiftUI

struct home: View {
    var body: some View {
        ZStack {
            Color(UIColor.systemGray5)
                .ignoresSafeArea()
            VStack(spacing: 5){
                VStack(alignment: .leading, spacing: 20) {
                    Text("Hello, resident")
                        .bold()
                        .font(.system(size: 25))
                    Text("Trending")
                        .font(.system(size: 25))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 1) {
                        PostBox_Trending(name: "first last", fontSize: 21)
                        PostBox_Trending(name: "not peter", fontSize: 21)
                        PostBox_Trending(name: "hi bye", fontSize: 21)
                    }
                }
                SortButton()
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 15) {
                        PostBox_Main(name: "danny yao", date: "Feb 26th, 2024", commentCount: 4, sentCount: 5, bookmarkCount: 6)
                        PostBox_Main(name: "21 21 21", date: "Feb 27th, 2994", commentCount: 7, sentCount: 8, bookmarkCount: 9)
                    }
                }

                Spacer()
            }
        }
    }
}

#Preview {
    home()
}
