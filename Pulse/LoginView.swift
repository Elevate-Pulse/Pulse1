//  login.swift

// PUT FNS IN A VIEWMODEL

import SwiftUI

struct LoginView: View {
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
                                        .font(.custom("Poppins-Light", size: 24))
                                }
                    Button(action: {
                                    print("Sign up tapped")
                                }) {
                                    Text("Sign up")
                                        .foregroundColor(Color.black)
                                        .font(.custom("Poppins-Light", size: 24))
                                }
                }
                TextField_Base(typeOfText: "Email", text: $username)
                SecureField_Base(typeOfText: "Password", text: $password)
                Button(action: {
                                print("Logged in")
                            }) {
                                Text("Login")
                                    .foregroundColor(Color.white)
                                    .font(.custom("Poppins-Light", size: 21))
                                    .padding()
                                    .frame(width: 300, height: 50)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(red: 35/255, green: 109/255, blue: 97/255)))
                            }
                Button(action: {
                                print("Skipped")
                            }) {
                                Text("Skip")
                                    .foregroundColor(Color.black)
                                    .font(.custom("Poppins-Light", size: 21))
                            }
            }
            .padding()
        }
    }
}

#Preview {
    LoginView()
}
