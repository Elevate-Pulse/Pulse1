import SwiftUI

struct SignupView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var neighborhood = ""
    @State private var createPw = ""
    @State private var repeatPw = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            Color(red: 1.0, green: 0.996, blue: 0.953)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image("pulse_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.bottom, -50)
                
                HStack(spacing: 20) {
                    NavigationLink(destination: LoginView()) {
                        Text("Login")
                            .foregroundColor(Color(red: 28/255, green: 21/255, blue: 21/255))
                            .font(.custom("Comfortaa-Regular", size: 21))
                    }
                    
                    NavigationLink(destination: SignupView()) {
                        Text("Sign up")
                            .foregroundColor(Color(red: 28/255, green: 21/255, blue: 21/255))
                            .font(.custom("Comfortaa-Regular", size: 21))
                            .underline()
                    }
                }
                
                TextField_Base(typeOfText: "Username or name", text: $name)
                TextField_Base(typeOfText: "Email", text: $email)
                SecureField_Base(typeOfText: "Create password", text: $createPw)
                SecureField_Base(typeOfText: "Repeat password", text: $repeatPw)
                
                Button(action: {
                    Task {
                        try await viewModel.register(withEmail: email, pw: createPw, name: name)
                    }
                }) {
                    Text("Sign up")
                        .foregroundColor(Color.white)
                        .font(.custom("Comfortaa-Regular", size: 18))
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(RoundedRectangle(cornerRadius: 25).fill(Color(red: 35/255, green: 109/255, blue: 97/255)))
                        .disabled(!formIsValid)
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

extension SignupView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty && email.contains("@") && !createPw.isEmpty && createPw.count > 5 && !name.isEmpty && createPw == repeatPw
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
            .environmentObject(AuthViewModel())
    }
}
