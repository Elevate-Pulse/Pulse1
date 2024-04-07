import SwiftUI
import Firebase
import FirebaseFirestore

struct pushToFirebase: View {
    @State var textToAdd: String = ""
    @State var textToRecieve: String = ""
    @State var textToChange: String = ""
    @State var textToDelete: String = ""
    
    @State var Q1_answer1: Int = 0
    
    
    var body: some View {
        VStack {
            TextField("field to add", text: $textToAdd)
                .autocorrectionDisabled()
            TextField("field to recieve", text: $textToRecieve)
                .autocorrectionDisabled()
            TextField("field to update", text: $textToChange)
                .autocorrectionDisabled()
            TextField("data to delete", text: $textToDelete)
                .autocorrectionDisabled()
            Button() {
                pushTextToFirebase(text: Int(textToAdd) ?? 0)
                //it wont fail converting to int bc it's a slider of ints
            }label: {
                Text("Push to firebase")
            }
            Button() {
//                Task{await getTextFromFirebase()}
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
    func pushTextToFirebase(text: Int) {
        let fs = Firestore.firestore()
        let surveyResponse: [String: Any] = ["countFor1" : text]
        //making a dictionary with key countFor1 and value text; this is what will show up in the document
        fs.collection("survey_answers").addDocument(data: surveyResponse)
        //search for survey_answers collection add to a document with dictionary
    }
    
    func getCount(question: String, answer: Int) async -> Int {
        var count: Int = 0
        let fs = Firestore.firestore()
        let survey = fs.collection("survey_answers")
        
        // Apply both filters at once before fetching the documents
        let query = survey //inside or before do
            .whereField("question", isEqualTo: question)
            .whereField("answer", isEqualTo: answer)
        
        do {
            let snapshot = try await query.getDocuments()
            count = snapshot.documents.count // Directly get the count of documents matching the criteria
        } catch {
            print("Error in retrieving firebase text", error.localizedDescription)
        }
        
        return count
    }
    
    func updateField(text: String) async {
        do {
            let fs = Firestore.firestore()
            let retrieveDoc = try await fs.collection("DocumentName").whereField("DocumentName", isEqualTo:text).getDocuments().documents[0]
            //go to collection documentName, gets all docs with value in field documentName equal to text, gets the first doc that matches
            let newTextData: [String: Any] = ["DocumentName": textToChange]
            //for doc with field documentName set the value to textToChange
            try await retrieveDoc.reference.setData(newTextData, merge: true)
            //updates doc with new data; merge new data with existing data in doc, rather than replacing it entirely
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
    pushToFirebase()
}
