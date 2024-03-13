//
//  ProfileView.swift
//  Pulse
//
//  Created by student on 3/12/21.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            Color(UIColor.systemGray5)
                .ignoresSafeArea()
            VStack {
                Text("Profile")
                    .font(.custom("Poppins-Light", size: 24))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                Circle()
                    .frame(width: 100)
                    .padding(.horizontal, 8)
                    .foregroundColor(Color(UIColor.darkGray))
                HStack {
                    VStack {
                        VStack {
                            Text("Name")
                                .font(.custom("Poppins-Light", size: 21))
                                .foregroundColor(Color(UIColor.darkGray))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Peter Guan")
                                .font(.custom("Poppins-Light", size: 21))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.vertical, 10)
                        VStack {
                            Text("Neighborhood")
                                .font(.custom("Poppins-Light", size: 21))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(Color(UIColor.darkGray))
                            Text("Lakeview")
                                .font(.custom("Poppins-Light", size: 21))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    EditButton()
                }
                .padding([.vertical, .horizontal], 10)
                ScrollView(.vertical, showsIndicators: false) {
                    Text("Posts you saved")
                        .font(.custom("Poppins-Light", size: 21))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 5) {
                            PostBox_Trending(height: 110, color: Color(UIColor.darkGray), bodyText: "abc def gh ijk l mn opq rst uv wx yz......................dsdsdsdsdsdsdsdsddsds..........", name: "first last", fontSize: 21) //implemented in HomeView
                            PostBox_Trending(height: 110, color: Color(UIColor.darkGray), bodyText: "haha", name: "not peter", fontSize: 21) //implemented in HomeView
                            PostBox_Trending(height: 110, color: Color(UIColor.darkGray), bodyText: "test", name: "hi bye", fontSize: 21) //implemented in HomeView
                        }
                    }
                    .padding(.horizontal, 15)
                    Text("Posts you made")
                        .font(.custom("Poppins-Light", size: 21))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 5) {
                            PostBox_Trending(height: 110, color: Color(UIColor.darkGray), bodyText: "abc def gh ijk l mn opq rst uv wx yz......................dsdsdsdsdsdsdsdsddsds..........", name: "first last", fontSize: 21) //implemented in HomeView
                            PostBox_Trending(height: 110, color: Color(UIColor.darkGray), bodyText: "haha", name: "not peter", fontSize: 21) //implemented in HomeView
                            PostBox_Trending(height: 110, color: Color(UIColor.darkGray), bodyText: "test", name: "hi bye", fontSize: 21) //implemented in HomeView
                        }
                    }
                    .padding(.horizontal, 15)
                    Text("Pulse Helper responses")
                        .font(.custom("Poppins-Light", size: 21))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 5) {
                            PostBox_Trending(height: 110, color: Color(UIColor.darkGray), bodyText: "abc def gh ijk l mn opq rst uv wx yz......................dsdsdsdsdsdsdsdsddsds..........", name: "first last", fontSize: 21) //implemented in HomeView
                            PostBox_Trending(height: 110, color: Color(UIColor.darkGray), bodyText: "haha", name: "not peter", fontSize: 21) //implemented in HomeView
                            PostBox_Trending(height: 110, color: Color(UIColor.darkGray), bodyText: "test", name: "hi bye", fontSize: 21) //implemented in HomeView
                        }
                    }
                    .padding(.horizontal, 15)
                }
            }
        }
    }
}


#Preview {
    ProfileView()
}
