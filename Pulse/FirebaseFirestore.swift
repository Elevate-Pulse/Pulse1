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
  var body: some View {
    VStack {
      TextField("Email", text: $email)
      SecureField("Password", text: $pw)
      Button(action: register) {
        Text("Register")
          .foregroundColor(.white)
          .frame(width: 200, height: 50)
          .background(Color.blue)
      }
    }
    .padding()
  }
  func register() {
    Auth.auth().createUser(withEmail: email, password: pw) { result, error in
      if let error = error {
        print("Login error")
      }
    }
  }
}


#Preview {
    RegisterTest()
}
