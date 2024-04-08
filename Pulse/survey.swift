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
    }
    private func completeSurvey() {
        let curUserID:String = Auth.auth().currentUser?.uid ?? "exampleID"
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
        let personalityTypes = ["Outgoing", "Open-Minded", "Private", "Engaged", "Easygoing"]
        return personalityTypes[mostFrequentAnswer]
    }
    
    func pushResponses(surveyData: [String: Any]) {
        let fs = Firestore.firestore()
        
        fs.collection("survey_responses").addDocument(data: surveyData) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
            }
        }
    }
}
