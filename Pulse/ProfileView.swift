//
//  ProfileView.swift
//  Pulse
//
//  Created by student on 3/12/21.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showingAlert = false
    @State private var deletionError = false
    @State private var alertMessage = ""
    @State private var selectedAction: AlertAction?

    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor(red: 1.0, green: 0.996, blue: 0.953, alpha: 1.0)) // Cream color
                    .ignoresSafeArea()
                
                VStack {
                    Text("Profile")
                        .font(.custom("Comfortaa-Regular", size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 24)
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        Button(action: {
                            // Show confirmation alert before performing any action
                            alertMessage = "Are you sure you want to log out?"
                            showingAlert = true
                            selectedAction = .logout
                        }) {
                            Text("Log Out")
                                .font(.custom("Comfortaa-Regular", size: 18))
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(RoundedRectangle(cornerRadius: 25).fill(Color(red: 35/255, green: 109/255, blue: 97/255)))
                        }

                        Button(action: {
                            // Show confirmation alert before deleting account
                            alertMessage = "Are you sure you want to delete your account? This action cannot be undone."
                            showingAlert = true
                            selectedAction = .deleteAccount
                        }) {
                            Text("Delete Account")
                                .font(.custom("Comfortaa-Regular", size: 18))
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(RoundedRectangle(cornerRadius: 25).fill(Color.red))
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    Spacer()
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text(selectedAction == .deleteAccount ? "Delete Account" : "Log Out"),
                    message: Text(alertMessage),
                    primaryButton: .destructive(Text(selectedAction == .deleteAccount ? "Delete" : "Log out")) {
                        // Perform action based on selected option
                        handleAction(selectedAction)
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }

    private func handleAction(_ action: AlertAction?) {
        guard let action = action else { return }
        switch action {
        case .logout:
            viewModel.logout()
        case .deleteAccount:
            deleteAccount()
        }
    }

    func deleteAccount() {
        Task {
            do {
                try await viewModel.deleteAccount()
                // Navigate back to the login view after successful deletion
                viewModel.logout()
            } catch {
                // Show error message if deletion fails
                deletionError = true
                print("Error deleting account: \(error.localizedDescription)")
            }
        }
    }

    enum AlertAction {
        case logout
        case deleteAccount
    }
}



#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}
