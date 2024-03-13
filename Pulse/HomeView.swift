//home.swift

import SwiftUI

struct HomeView: View {
    let name: String
    var body: some View {
        ZStack {
            Color(UIColor.systemGray5)
                .ignoresSafeArea()
            VStack(spacing: 0){
                VStack(alignment: .leading, spacing: 10) {
                    Text("Hello, \(name)")
                        .bold()
                        .font(.custom("Poppins-Light", size: 24))
                    Text("Trending")
                        .font(.custom("Poppins-Light", size: 24))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.horizontal, .vertical], 10)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 5) {
                        PostBox_Trending(height: 150, color: .red, bodyText: "abc def gh ijk l mn opq rst uv wx yz......................dsdsdsdsdsdsdsdsddsds..........", name: "first last", fontSize: 21)
                        PostBox_Trending(height: 150, color: .red, bodyText: "haha", name: "not peter", fontSize: 21)
                        PostBox_Trending(height: 150, color: .red, bodyText: "test", name: "hi bye", fontSize: 21)
                    }
                }
                .padding(.horizontal, 10)
                AllTagButtons()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 10)
                Spacer()
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        PostBox_Main(name: "danny yao", date: "Feb 26th, 2024", bodyText: "short test 2", commentCount: 4, sentCount: 5, bookmarkCount: 6)
                        PostBox_Main(name: "21 21 21", date: "Feb 27th, 2994", bodyText: "longtestlongtestlongtestlongtestlongtestlongtestlongtestlongtestlongtestlongtestlongtestlongtestlongtestlongtestlongtestlongtestlongtest", commentCount: 7, sentCount: 8, bookmarkCount: 9)
                    }
                }

                Spacer()
            }
        }
    }
}

#Preview {
    HomeView(name: "Peter")
}
