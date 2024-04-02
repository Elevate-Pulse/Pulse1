import SwiftUI
import Firebase
import FirebaseFirestore

struct pushToFirebase: View {
    @State var textToAdd: String = ""
    @State var textToRecieve: String = ""
    @State var textToChange: String = ""
    @State var textToDelete: String = ""
    var body: some View {
        VStack {
            TextField("field to add", text: $textToAdd)
            TextField("field to recieve", text: $textToRecieve)
            TextField("field to update", text: $textToChange)
            TextField("data to delete", text: $textToDelete)
            Button() {
                pushTextToFirebase(text: textToAdd)
            }label: {
                Text("Push to firebase")
            }
            Button() {
                Task{await getTextFromFirebase()}
            }label: {
                Text("get text from firebase")
            }
            Button() {
                Task{await updateField(text: textToAdd)}
            }label: {
                Text("update in firebase")
            }
            Button() {
                Task{await docToDelete(text: textToDelete)}
            }label: {
                Text("delete in firebase")
            }
        }
    }
    func pushTextToFirebase(text: String) {
        let fs = Firestore.firestore()
        var text: [String: Any] = ["DocumentName" : textToAdd]
        fs.collection("DocumentName").addDocument(data: text)
    }
    func getTextFromFirebase() async {
        let fs = Firestore.firestore()
//        var recievedText: [String: Any] = [:]
        do {
            var dataPoint = fs.collection("DocumentName")
            var dataSnapshot = try await dataPoint.getDocuments()
            let randomText = dataSnapshot.documents.randomElement()
            let randomTextData: [String: Any] = randomText!.data() ? [:]
            
            let textToRecieve = randomTextData["userEnteredText"] as! String
            
        } catch {
            print("Error in retrieving firebase text", error.localizedDescription)
        }
    }
    func updateField(text: String) async {
        do {
            let fs = Firestore.firestore()
            let retrieveDoc = try await fs.collection("DocumentName").whereField("DocumentName", isEqualTo:text).getDocuments().documents[0]
            var newTextData: [String: Any] = ["DocumentName": textToChange]
            try await retrieveDoc.reference.setData(newTextData, merge: true)
        } catch{
            print("error updating doc", error.localizedDescription)
        }
    }
    func docToDelete(text: String) async {
        do{
            let fs = Firestore.firestore()
            let retrieveDoc = try await fs.collection("DocumentName").whereField("DocumentName", isEqualTo:text).getDocuments().documents[0]
            try await retrieveDoc.reference.delete()
        } catch {
            print("error deleting doc", error.localizedDescription)
        }
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
