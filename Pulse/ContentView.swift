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
 -Increase distance between the comments and sent and bookmark buttons cause number tweaking
 -Create dropdown menus for anything involving dropdown menus
 -Fix QuestionTextfield to appear on top left of textfield
 */

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                }
            CreatePostView()
                .tabItem {
                    Image(systemName: "plus")
                }
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
        .environmentObject(AuthViewModel())
}
