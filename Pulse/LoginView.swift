import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var rememberMe = false // State for "Remember Me" toggle
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var isAnimating = false
    @State private var showAlert = false // State to control the alert
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 1.0, green: 0.996, blue: 0.953)
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    Image("pulse_logo")
                        .resizable() // Make the image resizable
                        .scaledToFit() // Fit the image within its frame
                        .frame(width: 200, height: 200)
                        .opacity(isAnimating ? 1.0 : 0.0)
                        .padding(.bottom, -50)
                    
                    HStack(spacing: 20) {
                        NavigationLink(destination: LoginView().environmentObject(viewModel)) {
                            Text("Login")
                                .foregroundColor(Color(red: 28/255, green: 21/255, blue: 21/255))
                                .font(.custom("Comfortaa-Regular", size: 21))
                                .opacity(isAnimating ? 1.0 : 0.0)
                                .underline()
                        }
                        
                        // Navigate to SignupView
                        NavigationLink(destination: SignupView().environmentObject(viewModel)) {
                            Text("Sign up")
                                .foregroundColor(Color(red: 28/255, green: 21/255, blue: 21/255))
                                .font(.custom("Comfortaa-Regular", size: 21))
                                .opacity(isAnimating ? 1.0 : 0.0)
                        }
                    }
                    
                    TextField_Base(typeOfText: "Email", text: $email)
                        .opacity(isAnimating ? 1.0 : 0.0)
                    
                    SecureField_Base(typeOfText: "Password", text: $password)
                        .opacity(isAnimating ? 1.0 : 0.0)
                    
                    // Moved "Remember Me" toggle here
                    HStack {
                        Button(action: {
                            rememberMe.toggle()
                        }) {
                            Image(systemName: rememberMe ? "checkmark.square" : "square")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(rememberMe ? Color(red: 35/255, green: 109/255, blue: 97/255) : .gray)
                        }
                        Text("Remember me")
                            .font(.custom("Comfortaa-Regular", size: 18))
                            .foregroundColor(Color(red: 28/255, green: 21/255, blue: 21/255))
                    }
                    .padding(.leading, -125)
                    .opacity(isAnimating ? 1.0 : 0.0)
                    
                    Button(action: {
                        // Attempt login
                        Task {
                            do {
                                try await viewModel.login(withEmail: email, pw: password)
                            } catch {
                                showAlert = true // Set to true to show alert on failure
                            }
                        }
                    }) {
                        Text("Login")
                            .foregroundColor(Color.white)
                            .font(.custom("Comfortaa-Regular", size: 18))
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(RoundedRectangle(cornerRadius: 25).fill(Color(red: 35/255, green: 109/255, blue: 97/255)))
                            .disabled(!formIsValid)
                            .opacity(isAnimating ? 1.0 : 0.0)
                    }
                }
                .padding()
                .onAppear {
                    withAnimation(.easeIn(duration: 1)) {
                        isAnimating = true
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Login Failed"), message: Text("Email or password is incorrect."), dismissButton: .default(Text("OK")))
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
