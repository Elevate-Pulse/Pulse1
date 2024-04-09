/*
-Registerering an acc should go to survey
 -Store goals locally
 -Make friends screen look sexy
 -Circle size update
 -Store user personality to firebase so that it displays the right one on homeview1 + 
 -Strengths and weaknesses of each personality
 
 -Randomize goals every wk
 -Apple login
 -Remove back button from login/signup screen

 */

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var isAuthenticated = false

    var body: some View {
        Group {
            if isAuthenticated {
                if let currentUser = viewModel.currentUser {
                    if currentUser.timesLoggedIn == 0 && currentUser.initialSurvey == false {
                        dashboard()
                    } else {
                        mainContentView()
                    }
                } else {
                    LoginView()
                    //ProgressView() // You can display a loading indicator here if currentUser is still being fetched
                }
            } else {
                LoginView()
            }
        }
        .onReceive(viewModel.$userSession) { userSession in
            isAuthenticated = userSession != nil
        }.navigationBarBackButtonHidden(true)
    }

    @ViewBuilder
    func mainContentView() -> some View {
        if viewModel.currentUser != nil {
                TabView {
                    HomeView1()
                        .tabItem {
                            Image(systemName: "house")
                        }
                    newDashboard()
                        .tabItem {
                            Image(systemName: "chart.bar")
                        }
                    ProfileView()
                        .tabItem {
                            Image(systemName: "person")
                        }
                }
                .onAppear {
                    // Customize tab bar appearance
                    let tabBarAppearance = UITabBarAppearance()
                    tabBarAppearance.backgroundColor = UIColor(red: 1.0, green: 0.996, blue: 0.953, alpha: 1.0)
                    
                    // Apply the appearance to the tab bar
                    UITabBar.appearance().standardAppearance = tabBarAppearance
                    UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                }.accentColor(Color(red: 35/255, green: 109/255, blue: 97/255))
            }
        }

}
#Preview {
    NavigationView {
        ContentView()
            .environmentObject(AuthViewModel())
    }

}
