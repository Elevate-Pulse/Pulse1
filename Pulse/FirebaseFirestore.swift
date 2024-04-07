import SwiftUI
import Firebase
import FirebaseFirestore

struct pushToFirebase: View {
    @State var textToAdd: String = ""
    @State var textToChange: String = ""
    @State var textToDelete: String = ""
    var body: some View {
        VStack {
            TextField("field we're changing or add", text: $textToAdd)
                .autocapitalization(.none)
            TextField("text that it's being changed into", text: $textToChange)
            TextField("data to delete", text: $textToDelete)

            Button() {
                pushTextToFirebase(text: textToAdd)
            }label: {
                Text("Push to firebase")
            }
            Button() {
                
                Task{await updateField(text: textToAdd)}
            }label: {
                Text("Update Data In Firebase")
            }
            Button() {
                
                Task{await docToDelete(text: textToDelete)}
            }label: {
                Text("DELETE DOC")
            }
        }
    }
    func pushTextToFirebase(text: String) {
        let fs = Firestore.firestore()
        var text: [String: Any] = ["Interests" : [textToAdd]]
        fs.collection("DocumentName").addDocument(data: text)
    }
    func updateField(text: String) async {
        do {
            let fs = Firestore.firestore()
            let retrieveDoc = try await fs.collection("DocumentName").whereField("Interests", arrayContains: text).getDocuments().documents[0]
            //var newTextData: [String: Any] = ["DocumentName" : textToChange]
                                              //, "favMovi" : "idk"]
            var retrievedData: [String: Any] = retrieveDoc.data()
            var newDataToAppend: [String] = retrievedData["Interests"] as! [String]
            newDataToAppend.append(textToChange)
            retrievedData["Interests"] = newDataToAppend
            try await retrieveDoc.reference.setData(retrievedData, merge: true)
     
        } catch {
            print("error updating document", error.localizedDescription)
        }
    }
    func docToDelete(text: String) async {
        do {
            let fs = Firestore.firestore()
            let retrieveDoc = try await fs.collection("DocumentName").whereField("DocumentName" , isEqualTo: text).getDocuments().documents[0]
            try await retrieveDoc.reference.delete()
            
        } catch {
            print("error deleting document", error.localizedDescription)
        }
    }
}




#Preview {
    pushToFirebase()
}

