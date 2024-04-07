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
 -Ugly blue back button when I go back from the edit button in profile
 -Link buttons to one another
 */

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(name: "Peter")
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(0)
            CreatePostView(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "plus")
                }
                .tag(1)
//            dashboard()
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
