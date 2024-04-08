//
//  Test1.swift
//  Pulse
//
//  Created by Peter Guan on 4/7/24.
//

import SwiftUI

struct Test1: View {
    // Define a state variable to track whether the dashboard view should be presented
    @State private var isDashboardActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Your other screen content here
                Button(action: {
                    // Set the state variable to true to activate the navigation link
                    self.isDashboardActive = true
                }) {
                    Text("Retake Survey")
                        .foregroundColor(Color(red: 35/255, green: 109/255, blue: 97/255))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .font(.custom("Comfortaa-Regular", size: 15))
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(Color(red: 1.0, green: 0.996, blue: 0.953))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color(red: 35/255, green: 109/255, blue: 97/255), lineWidth: 2)
                                )
                        )
                }
                // Use the NavigationLink to conditionally navigate to the dashboard view
                NavigationLink(destination: dashboard(), isActive: $isDashboardActive) {
                    EmptyView() // Use EmptyView if you don't want to display any visible link
                }
            }
            .navigationTitle("Other Screen")
        }
    }
}
//

#Preview {
    Test1()
}
