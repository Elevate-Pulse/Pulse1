//
//  GoalProgressTest.swift
//  Pulse
//
//  Created by Litao Li on 4/9/24.
//

import SwiftUI
import FirebaseFirestore
import Firebase

struct GoalProgressTest: View {
    var progressNum = 3
    var goal = "goal1"
    @State private var goalProgress: [Int] = []
    
    var body: some View {
        VStack {
            Text("Goal Progress")
                .font(.title)
                .padding()
            
            // Display goal progress data
            
            ForEach(0..<goalProgress.count, id: \.self) { index in
                Text("Goal \(index + 1): \(goalProgress[index])")
                    .padding()
            }
            
            
            Spacer()
            
            //                Button("Fetch Goal Progress") {
            //                    // Call the function to fetch goal progress data
            //                    goalProgress = getGoalProgress()
            //                }
            //                .padding()
        }
        .onAppear {
            // Fetch goal progress data when the view appears
            //                goalProgress = getGoalProgress()
            //                updateGoalProgress(progressNum: progressNum, goal: goal)
            Task {
                print("Inside Task")
                do {
                    goalProgress = try await getGoalProgress()
                } catch {
                    print("Error fetching network data: \(error)")
                }
            }
        }
    }
    
    // Update the Goal Progress onto Firebase
    func updateGoalProgress(progressNum: Int, goal: String) {
        let fs = Firestore.firestore()
        
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        
        
        let goalProgressCollection = fs.collection("goal_progress")
        
        // Create a query to get documents with matching userID
        let goalProgressQuery = goalProgressCollection.whereField("userID", isEqualTo: userID)
        
        goalProgressQuery.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching goal progress: \(error.localizedDescription)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                return
            }
            
            // Loop through the documents
            for document in documents {
                var data = document.data()
                
                // Update the progress for the specified goal
                if var currentProgress = data[goal] as? Int {
                    currentProgress += progressNum
                    data[goal] = currentProgress
                    
                    // Check if the goal has reached or exceeded 7
                    if currentProgress >= 7 {
                        // Increase the level by 1
                        if var level = data["level"] as? Int {
                            level += 1
                            data["level"] = level
                        }
                        
                        // Reset the goal progress
                        data[goal] = currentProgress - 7
                    }
                    
                    // Update the document
                    document.reference.setData(data) { error in
                        if let error = error {
                            print("Error updating document: \(error.localizedDescription)")
                        } else {
                            print("Document updated successfully")
                        }
                    }
                }
            }
        }
    }
    
    // Pull goal progress from Firebase
    func getGoalProgress() async -> [Int] {
        var goalProgress: [Int] = []
        let fs = Firestore.firestore()
        
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return goalProgress
        }
        
        
        let goalProgressCollection = fs.collection("goal_progress")
        do {
            // Create a query to get documents with matching userID
            let goalProgressQuery = goalProgressCollection.whereField("userID", isEqualTo: userID)
            
            let goalProgressSnapshot = try await goalProgressQuery.getDocuments()
            
            for document in goalProgressSnapshot.documents {
                
                let data = document.data()
                
                // Retrieve the values for "goal1", "goal2", "goal3", and "level"
                if let goal1 = data["goal1"] as? Int,
                   let goal2 = data["goal2"] as? Int,
                   let goal3 = data["goal3"] as? Int,
                   let level = data["level"] as? Int {
                    goalProgress.append(contentsOf: [goal1, goal2, goal3, level])
                }
                
            }
        } catch {
            print("Error fetching goal progress: \(error.localizedDescription)")
        }
        return goalProgress
    }
}



#Preview {
    GoalProgressTest()
}
