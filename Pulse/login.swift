//  login.swift

// PUT FNS IN A VIEWMODEL

import SwiftUI

struct login: View {
    @State private var username = ""
    @State private var password = ""
    var body: some View {
        ZStack {
            Color(UIColor.systemGray5)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Circle()
                    .frame(width:100)
                    .padding()
                HStack(spacing: 20) {
                    Button(action: {
                                    print("Login tapped")
                                }) {
                                    Text("Login")
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 24))
                                }
                    Button(action: {
                                    print("Sign up tapped")
                                }) {
                                    Text("Sign up")
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 24))
                                }
                }
                TextField_Base(typeOfText: "Email", text: $username)
                SecureField_Base(text: $password)
                Button(action: {
                                print("Logged in")
                            }) {
                                Text("Login")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 21))
                                    .padding()
                                    .frame(width: 160, height: 50)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.darkGray)))
                                
                            }
                
                Button(action: {
                                print("Skipped")
                            }) {
                                Text("Skip")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 21))
                            }
            }
            .padding()
        }
    }
}

#Preview {
    login()
}
