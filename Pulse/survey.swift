//  survey.swift
//  Pulse
//
//  Created by Yinglin Jiang on 3/19/24.
import SwiftUI
import FirebaseFirestore
import FirebaseAuth
struct SurveyQuestion: Identifiable {
    let id: Int
    let text: String
    let type: QuestionType
    let answers: [String]? // 'nil' for slider-based questions
    
    enum QuestionType {
        case slider
        case multipleChoice
    }
}
struct SurveyQuestionView: View {
    @Binding var selectedSliderAnswers: [Int]
    @Binding var selectedMCAnswer: [Int]
    @State private var currentQuestionIndex = 0
    let questions: [SurveyQuestion]
    let onClose: () -> Void
    let range: ClosedRange<Int>
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var isNavigationActive = false
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView{
                VStack(alignment: .leading, spacing: 20) {
                    Text("Answer the survey to see your community health dashboard")
                        .multilineTextAlignment(.center)
                    
                    Text(questions[currentQuestionIndex].text)
                        .bold()
                    
                    if questions[currentQuestionIndex].type == .slider {
                        Slider(value: Binding(
                            get: { Double(selectedSliderAnswers[currentQuestionIndex]) },
                            set: { selectedSliderAnswers[currentQuestionIndex] = Int($0) }
                        ), in: Double(range.lowerBound)...Double(range.upperBound))
                        HStack {
                            ForEach(range, id: \.self) { number in
                                Text("\(number)                                 ").tag(number)
                            }
                        }.padding (.leading, 20)
                    } else if let mcAnswers = questions[currentQuestionIndex].answers, questions[currentQuestionIndex].type == .multipleChoice {
                        VStack {
                            ForEach(0..<mcAnswers.count, id: \.self) { index in
                                Button(action: {
                                    // Update the selected answer for the current MC question
                                    let mcIndex = currentQuestionIndex - 5 // Adjust based on the number of slider questions
                                    selectedMCAnswer[mcIndex] = index
                                }) {
                                    HStack {
                                        Text(mcAnswers[index])
                                            .foregroundColor(.black)
                                            .padding()
                                        Spacer()
                                    }
                                    .background(self.isOptionSelected(mcIndex: currentQuestionIndex - 5, optionIndex: index) ? Color.blue.opacity(0.2) : Color.clear)
                                    .cornerRadius(5)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        
                    }
                    // Spacer()
                    
                    Button(currentQuestionIndex == questions.count - 1 ? "Close" : "Next") {
                        if currentQuestionIndex == questions.count - 1 {
                            completeSurvey() // Close the survey
                        } else {
                            goToNextQuestion() // Go to next question
                        }
                    }
                }
                .padding()
            }
            .frame(maxHeight: geometry.size.height * 0.7)
        }
        //.navigationTitle("Survey") // Set navigation title
        .navigationBarBackButtonHidden(true) // Hide back button
        .navigationBarItems(trailing: NavigationLink(destination: ContentView().environmentObject(viewModel), isActive: $isNavigationActive) {
            EmptyView()
        })
    }
    private func completeSurvey() {
        guard let currentUser = viewModel.currentUser else {
            // Handle the case where currentUser is nil
            print("Error: currentUser is nil")
            return
        }
        
        let curUserID: String = Auth.auth().currentUser?.uid ?? "exampleID"
        // Calculate the personality type based on the most selected MC answer
        let personalityType = calculatePersonalityType(from: selectedMCAnswer)
        // Prepare the survey data for submission
        var surveyData: [String: Any] = [
            "userID": curUserID,  // Use the actual user ID here
            "personalityType": personalityType
        ]
        // Append each slider question's answer
        for (index, answer) in selectedSliderAnswers.enumerated() {
            let questionKey = "question\(index + 1)"
            surveyData[questionKey] = answer
        }
        // Push the survey results to Firebase
        pushResponses(surveyData: surveyData)
        
        // Increment timesLoggedIn count and set initialSurvey to true
        do {
            Task {
                await viewModel.updateLoginCount()
                // Set initialSurvey to true
                currentUser.initialSurvey = true
                // Print out timesLoggedIn
                print("timesLoggedIn: \(viewModel.currentUser?.timesLoggedIn ?? 9999999)")
                // Present ContentView after completing the survey
                isNavigationActive = true
            }
        } catch {
            print("Error incrementing timesLoggedIn count: \(error.localizedDescription)")
        }
        // Close the survey view
        onClose()
    }
    
    
    private func goToNextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            // Move to the next question
            currentQuestionIndex += 1
        } else {
            // Last question already answered, so complete the survey
            completeSurvey()
        }
    }
    
    private func isOptionSelected(mcIndex: Int, optionIndex: Int) -> Bool {
        // Adjusting mcIndex to be non-negative in case of questions[currentQuestionIndex].type == .multipleChoice
        let adjustedMcIndex = max(mcIndex, 0)
        return selectedMCAnswer.indices.contains(adjustedMcIndex) && selectedMCAnswer[adjustedMcIndex] == optionIndex
    }
    
    private func calculatePersonalityType(from answers: [Int]) -> String {
        let answerCounts = answers.reduce(into: [:]) { counts, answer in
            counts[answer, default: 0] += 1
        }
        
        guard let mostFrequentAnswer = answerCounts.max(by: { $0.value < $1.value })?.key else {
            return "Undetermined" // Or handle this case as appropriate
        }
        
        // Map the most frequent answer to a personality type
        let personalityTypes = ["Outgoing Spirit", "Open-Minded Explorer", "Private Resident", "Engaged Citizen", "Easygoing Neighbor"]
        print (personalityTypes[mostFrequentAnswer])
        return personalityTypes[mostFrequentAnswer]
    }
    
    func pushResponses(surveyData: [String: Any]) {
        let fs = Firestore.firestore()
        let curUserID = Auth.auth().currentUser?.uid ?? "exampleID"
        // Check if the document for the current user already exists
        let surveyResponsesRef = fs.collection("survey_responses")
        surveyResponsesRef.whereField("userID", isEqualTo: curUserID).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else if querySnapshot!.documents.count != 0 {
                // Document for the user exists, so update it
                let documentID = querySnapshot!.documents.first!.documentID
                surveyResponsesRef.document(documentID).updateData(surveyData) { error in
                    if let error = error {
                        print("Error updating document: \(error)")
                    } else {
                        print("Document successfully updated!")
                    }
                }
            } else {
                // No document exists for the user, create a new one
                surveyResponsesRef.addDocument(data: surveyData) { error in
                    if let error = error {
                        print("Error writing document: \(error)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
        }
    }
}
#Preview{
    SurveyQuestionView(selectedSliderAnswers: .constant([3, 3, 3, 3, 3]), // Example values for selectedSliderAnswers
                       selectedMCAnswer: .constant([0, 0, 0, 0, 0]), // Example values for selectedMCAnswer
                       questions: [
                           SurveyQuestion(id: 0, text: "Example Slider Question 1", type: .slider, answers: nil),
                           SurveyQuestion(id: 1, text: "Example Slider Question 2", type: .slider, answers: nil),
                           // Add more example slider questions if needed
                           SurveyQuestion(id: 5, text: "Example Multiple Choice Question 1", type: .multipleChoice, answers: ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5"]),
                           SurveyQuestion(id: 6, text: "Example Multiple Choice Question 2", type: .multipleChoice, answers: ["Option A", "Option B", "Option C", "Option D", "Option E"])
                           // Add more example multiple-choice questions if needed
                       ],
                       onClose: {},
                       range: 1...5)
        .environmentObject(AuthViewModel())
}

