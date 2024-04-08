//
//  PulseApp.swift
//  Pulse
//
//  Created by Litao Li on 3/4/24.
//

import SwiftUI

//@main
//struct PulseApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}

@main
struct PulseApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


  var body: some Scene {
    WindowGroup {
      NavigationView {
//        ContentView()
//              .environmentObject(viewModel)
          FriendsTest()
      }
    }
  }
}
