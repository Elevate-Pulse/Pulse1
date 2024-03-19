import SwiftUI
import Firebase
import FirebaseFirestore

struct pushToFirebase: View {
    @State var textToAdd: String = ""
    var body: some View {
        VStack {
            TextField("", text: $textToAdd)
            Button() {
                pushTextToFirebase(text: textToAdd)
            }label: {
                Text("Push to firebase")
            }
        }
    }
    func pushTextToFirebase(text: String) {
        let fs = Firestore.firestore()
        var text: [String: Any] = ["test" : textToAdd]
        fs.collection("abc").addDocument(data: text)
    }
    
}

struct RegisterTest: View {
  @State var email: String = ""
  @State var pw: String = ""
    let registerViewModel = RegisterViewModel()
    var body: some View {
        VStack {
            TextField("Email", text: $email)
            SecureField("Password", text: $pw)
            Button(action: {
                registerViewModel.register(email: email, pw: pw) // Call the register method with email and password
            }) {
                Text("Register")
            }
        }
    }
}

func register(email: String, pw: String) {
    let registerViewModel = RegisterViewModel()
    registerViewModel.register(email: email, pw: pw)
}


struct RegisterViewModel {
    func register(email: String, pw: String) {
        
        Auth.auth().createUser(withEmail: email, password: pw) { result, error in
            if let error = error {
                print("Registration error:", error.localizedDescription)
            } else {
                print("Registration successful")
            }
        }
    }
}


#Preview {
    RegisterTest()
}
