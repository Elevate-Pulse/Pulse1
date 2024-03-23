//  login.swift

// PUT FNS IN A VIEWMODEL

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGray5)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Circle()
                    .frame(width:100)
                    .padding()
                    .opacity(isAnimating ? 1.0 : 0.0)
                
                HStack(spacing: 20) {
                    Button(action: {
                        //print("Login tapped")
                    }) {
                        Text("Login")
                            .foregroundColor(Color.black)
                            .font(.custom("Poppins-Light", size: 24))
                            .opacity(isAnimating ? 1.0 : 0.0)
                            .underline()
                    }
                    Button(action: {
                        //print("Sign up tapped")
                    }) {
                        Text("Sign up")
                            .foregroundColor(Color.black)
                            .font(.custom("Poppins-Light", size: 24))
                            .opacity(isAnimating ? 1.0 : 0.0)
                    }
                }
                
                TextField_Base(typeOfText: "Email", text: $email)
                    .opacity(isAnimating ? 1.0 : 0.0)
                
                SecureField_Base(typeOfText: "Password", text: $password)
                    .opacity(isAnimating ? 1.0 : 0.0)
                
                Button(action: {
                    //print("Logged in")
                    Task {
                        try await viewModel.login(withEmail: email, pw: password)
                    }
                }) {
                    Text("Login")
                        .foregroundColor(Color.white)
                        .font(.custom("Poppins-Light", size: 21))
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color(red: 35/255, green: 109/255, blue: 97/255)))
                        .disabled(!formIsValid)
                        .opacity(isAnimating ? 1.0 : 0.0)
                }
                
                Button(action: {
                    //print("Skipped")
                }) {
                    Text("Skip")
                        .foregroundColor(Color.black)
                        .font(.custom("Poppins-Light", size: 21))
                        .opacity(isAnimating ? 1.0 : 0.0)
                }
            }
            .padding()
            .onAppear {
                withAnimation(.easeIn(duration: 1.5)) {
                    isAnimating = true
                }
            }
        }
    }
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty && email.contains("@") && !password.isEmpty && password.count > 5
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
