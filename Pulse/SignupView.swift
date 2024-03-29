//  login.swift

// PUT FNS IN A VIEWMODEL

import SwiftUI

struct SignupView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var neighborhood = ""
    @State private var createPw = ""
    @State private var repeatPw = ""
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
                TextField_Base(typeOfText: "Name", text: $name)
                TextField_Base(typeOfText: "Email", text: $email)
                TextField_Base(typeOfText: "Dropdown for select neighborhood", text: $neighborhood)
                SecureField_Base(typeOfText: "Create password", text: $createPw)
                SecureField_Base(typeOfText: "Repeat password", text: $repeatPw)
                
                Button(action: {
                    register(email: email, pw: repeatPw)
                                print("Signed up")
                            }) {
                                Text("Sign up")
                                    .foregroundColor(Color.white)
                                    .font(.custom("Poppins-Light", size: 21))
                                    .padding()
                                    .frame(width: 300, height: 50)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(red: 35/255, green: 109/255, blue: 97/255)))
                                
                            }
                
                Button(action: {
                                print("already had an acc")
                            }) {
                                Text("Already have an account?")
                                    .foregroundColor(Color.black)
                                    .font(.custom("Poppins-Light", size: 16))
                                    .underline()
                            }
            }
            .padding()
        }
    }
}

#Preview {
    SignupView()
}
