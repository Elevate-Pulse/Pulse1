//
//  ProfileView.swift
//  Pulse
//
//  Created by student on 3/12/21.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGray5)
                    .ignoresSafeArea()
                VStack {
                    Text("Profile")
                        .font(.custom("Poppins-Light", size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 24)
                    Circle()
                        .frame(width: 100)
                        .foregroundColor(.black)
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
                    .padding([.vertical, .horizontal], 24)
                    ScrollView(.vertical, showsIndicators: false) {
                        Text("Posts you saved")
                            .font(.custom("Poppins-Light", size: 21))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 24)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 5) {
                                PostBox_Trending(height: 100, gradientColors: [Color(UIColor.darkGray)], bodyText: "abc def gh ijk l mn opq rst uv wx yz......................dsdsdsdsdsdsdsdsddsds..........", name: "first last", fontSize: 21) //implemented in HomeView
                                PostBox_Trending(height: 100, gradientColors: [Color(UIColor.darkGray)], bodyText: "abc def gh ijk l mn opq rst uv wx yz......................dsdsdsdsdsdsdsdsddsds..........", name: "first last", fontSize: 21) //implemented in HomeView
                                PostBox_Trending(height: 100, gradientColors: [Color(UIColor.darkGray)], bodyText: "abc def gh ijk l mn opq rst uv wx yz......................dsdsdsdsdsdsdsdsddsds..........", name: "first last", fontSize: 21) //implemented in HomeView
                            }
                        }
                        .padding(.horizontal, 24)
                        Text("Posts you made")
                            .font(.custom("Poppins-Light", size: 21))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 24)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 5) {
                                PostBox_Trending(height: 100, gradientColors: [Color(UIColor.darkGray)], bodyText: "abc def gh ijk l mn opq rst uv wx yz......................dsdsdsdsdsdsdsdsddsds..........", name: "first last", fontSize: 21) //implemented in HomeView
                                PostBox_Trending(height: 100, gradientColors: [Color(UIColor.darkGray)], bodyText: "abc def gh ijk l mn opq rst uv wx yz......................dsdsdsdsdsdsdsdsddsds..........", name: "first last", fontSize: 21) //implemented in HomeView
                                PostBox_Trending(height: 100, gradientColors: [Color(UIColor.darkGray)], bodyText: "abc def gh ijk l mn opq rst uv wx yz......................dsdsdsdsdsdsdsdsddsds..........", name: "first last", fontSize: 21) //implemented in HomeView
                            }
                        }
                        .padding(.horizontal, 24)
                        Text("Ripple's responses")
                            .font(.custom("Poppins-Light", size: 21))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 24)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 5) {
                                PostBox_Trending(height: 100, gradientColors: [Color(UIColor.darkGray)], bodyText: "abc def gh ijk l mn opq rst uv wx yz......................dsdsdsdsdsdsdsdsddsds..........", name: "first last", fontSize: 21) //implemented in HomeView
                                PostBox_Trending(height: 100, gradientColors: [Color(UIColor.darkGray)], bodyText: "abc def gh ijk l mn opq rst uv wx yz......................dsdsdsdsdsdsdsdsddsds..........", name: "first last", fontSize: 21) //implemented in HomeView
                                PostBox_Trending(height: 100, gradientColors: [Color(UIColor.darkGray)], bodyText: "abc def gh ijk l mn opq rst uv wx yz......................dsdsdsdsdsdsdsdsddsds..........", name: "first last", fontSize: 21) //implemented in HomeView
                            }
                        }
                        .padding(.horizontal, 24)
                    }
                }
                .navigationBarTitle("", displayMode: .inline)
            }
        }
    }
}


#Preview {
    ProfileView()
}
