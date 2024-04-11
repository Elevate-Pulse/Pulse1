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
    var progressNum = 1
    var goal = "goal1"
    @State private var goalProgress: [Int] = []
    
    var goalNames = ["lvl_ame", "lvl_eng", "lvl_phys", "lvl_safe", "lvl_soc"]

       var body: some View {
           VStack {
               Text("Goal Progress")
                   .font(.title)
                   .padding()
               
               // Display goal progress data
               ForEach(0..<goalProgress.count, id: \.self) { index in
                   if index < goalNames.count {
                       Text("\(goalNames[index]): \(goalProgress[index])")
                           .padding()
                   }
               }
               
               Spacer()
           }
        .onAppear {
            // Fetch goal progress data when the view appears
            //                goalProgress = getLvls()
            //                updateGoalProgress(progressNum: progressNum, goal: goal)
            Task {
                print("Inside Task")
                do {
                    goalProgress = try await getLvls()
                    print("done")
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
                    if currentProgress >= 8 {
                        // Increase the level by 1
                        if (goal == "goal1Progress") {
                            if var level = data["lvl_ame"] as? Int {
                                level += 1
                                data["lvl_ame"] = level
                            }
                        } else if (goal == "goal2Progress") {
                            if var level = data["lvl_eng"] as? Int {
                                level += 1
                                data["lvl_eng"] = level
                            }
                        } else if (goal == "goal3Progress") {
                            if var level = data["lvl_phys"] as? Int {
                                level += 1
                                data["lvl_phys"] = level
                            }
                        } else if (goal == "goal4Progress") {
                            if var level = data["lvl_safe"] as? Int {
                                level += 1
                                data["lvl_safe"] = level
                            }
                        } else if (goal == "goal5Progress") {
                            if var level = data["lvl_soc"] as? Int {
                                level += 1
                                data["lvl_soc"] = level
                            }
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
    func getLvls() async -> [Int] {
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
                if let lvl_ame = data["lvl_ame"] as? Int {
                    goalProgress.append(lvl_ame)
                }
                
                if let lvl_eng = data["lvl_eng"] as? Int {
                    goalProgress.append(lvl_eng)
                }
                
                if let lvl_phys = data["lvl_phys"] as? Int {
                    goalProgress.append(lvl_phys)
                }
                
                if let lvl_safe = data["lvl_safe"] as? Int {
                    goalProgress.append(lvl_safe)
                }
                
                if let lvl_soc = data["lvl_soc"] as? Int {
                    goalProgress.append(lvl_soc)
                }
                
            }
        } catch {
            print("Error fetching goal progress: \(error.localizedDescription)")
        }
        return goalProgress
    }
    
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
                
                // Retrieve the values for "goal1Progress", "goal2Progress", and "goal3Progress"
                if let goal1Progress = data["goal1Progress"] as? Int {
                    goalProgress.append(goal1Progress)
                }
                
                if let goal2Progress = data["goal2Progress"] as? Int {
                    goalProgress.append(goal2Progress)
                }
                
                if let goal3Progress = data["goal3Progress"] as? Int {
                    goalProgress.append(goal3Progress)
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
