//
//  test.swift
//  Pulse
//
//  Created by Yinglin Jiang on 4/6/24.
//

import SwiftUI
import FirebaseFirestore
import Firebase


struct test: View {
    @State var count: Int = 0
    
    var body: some View {
        VStack{
            Text("\(count)")
        }
        .onAppear {
            Task{
                
                do {
                    count = await getCount(question: "question1", answer: 3)
                }
            }
        }
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
        
}

#Preview {
    test()
}
