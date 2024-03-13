//
//  ContentView.swift
//  Pulse
//
//  Created by Litao Li on 3/4/24.
//

/*
To-do list:
 -There needs to be an expand/collapse button for posts longer than 3 lines
 -TabBar looks ugly when u scroll down on some screens
 */

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView(name: "Peter")
                .tabItem {
                    Image(systemName: "house")
                }
            CreatePostView()
                .tabItem {
                    Image(systemName: "plus")
                }
            Text("")
                .tabItem {
                    Image(systemName: "chart.bar")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
            }
        }
    }
}

#Preview {
    ContentView()
}
