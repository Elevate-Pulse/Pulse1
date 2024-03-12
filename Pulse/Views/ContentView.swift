//
//  ContentView.swift
//  Pulse
//
//  Created by Litao Li on 3/4/24.
//

/*
To-do list:
 -Info button has awkward positioning in createPost so how do I turn it into a TextField
 -There needs to be an expand/collapse button for posts longer than 3 lines
 */

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView(name: "Peter")
                .tabItem {
                    Image(systemName: "house")
                }
            Text("")
                .tabItem {
                    Image(systemName: "plus")
                }
            Text("")
                .tabItem {
                    Image(systemName: "chart.bar")
                }
            Text("")
                .tabItem {
                    Image(systemName: "person")
            }
        }
        
    }
}

#Preview {
    ContentView()
}
