import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var isAuthenticated = false

    var body: some View {
        Group {
            if isAuthenticated {
                mainContentView()
            } else {
                LoginView()
            }
        }
        .onReceive(viewModel.$userSession) { userSession in
            isAuthenticated = userSession != nil
        }
    }

    @ViewBuilder
    func mainContentView() -> some View {
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
#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}
