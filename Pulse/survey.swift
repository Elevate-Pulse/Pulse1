//
//  survey.swift
//  Pulse
//
//  Created by Yinglin Jiang on 3/19/24.
//

import SwiftUI

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
    @Binding var selectedSliderAnswer: Int
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
                        Slider(value: Binding(get: { Double(selectedSliderAnswer) }, set: { selectedSliderAnswer = Int($0.rounded()) }),
                               in: 1...5, step: 1)
                        HStack {
                            ForEach(range, id: \.self) { number in
                                Text("\(number)              ").tag(number)
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
                                .buttonStyle(PlainButtonStyle()) // Use PlainButtonStyle for iOS 14 compatibility
                            }
                        }
                        
                    }
                    // Spacer()
                    
                    Button("Next") {
                        goToNextQuestion()
                    }
                    .disabled(currentQuestionIndex >= questions.count - 1)
                }
                .padding()
            }
            .frame(maxHeight: geometry.size.height * 0.7)
        }
    }
    
    private func goToNextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            // For slider questions, reset the answer for the next question
            if questions[currentQuestionIndex].type == .slider {
                selectedSliderAnswer = 0 // Assuming midpoint as default
            }
            // No need to reset selectedMCAnswer here as its value is directly bound to the Picker
        } else {
            onClose() // All questions have been answered
        }
    }
    
    private func isOptionSelected(mcIndex: Int, optionIndex: Int) -> Bool {
        // Adjusting mcIndex to be non-negative in case of questions[currentQuestionIndex].type == .multipleChoice
        let adjustedMcIndex = max(mcIndex, 0)
        return selectedMCAnswer.indices.contains(adjustedMcIndex) && selectedMCAnswer[adjustedMcIndex] == optionIndex
    }
    
    func pushResponses(question: Int, userID: String) async {

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
    }
}
//struct SurveyQuestionView: View {
//    @Binding var selectedSliderAnswer: Int
//    @Binding var selectedMCAnswer: [Int]
//    //  @State private var currentQuestionIndex = 0
//    let questions: [SurveyQuestion]
//    //    @Binding var selectedAnswer: Int
//    @State private var currentQuestionIndex = 0
//    //    let questions: [String]
//    let range: ClosedRange<Int>
//    let onClose: () -> Void
//    
//    //    // Use a local variable to bind to the slider as a Double
//    //        private var sliderValue: Binding<Double> {
//    //            Binding<Double>(
//    //                get: { Double(selectedAnswer) },
//    //                set: { selectedAnswer = Int($0.rounded()) }
//    //            )
//    //        }
//    //        private func goToNextQuestion() {
//    //            if currentQuestionIndex < questions.count - 1 {
//    //                currentQuestionIndex += 1
//    //                selectedAnswer = range.lowerBound // Reset selected answer for the next question
//    //            } else {
//    //                onClose() // All questions have been answered, close the survey
//    //            }
//    //        }
//    
//    
//    var body: some View {
//        //            VStack(alignment: .leading, spacing: 20) {
//        //                Text("Answer the survey to see your community health dashboard")
//        //                    .multilineTextAlignment(.center)
//        //                Text(questions[currentQuestionIndex])
//        //                    .bold()
//        //                Slider(value: sliderValue, in: Double(range.lowerBound)...Double(range.upperBound), step: 1.0)
//        //                HStack {
//        //                    ForEach(range, id: \.self) { number in
//        //                        Text("\(number)").tag(number)
//        //                    }
//        //                }
//        //
//        //                HStack {
//        //                    Button("Next") {
//        //                        goToNextQuestion()
//        //                    }
//        //                    .disabled(currentQuestionIndex >= questions.count - 1) // Disable "Next" if this is the last question
//        //
//        //                    Button("Close") {  // This button will close the popup
//        //                        onClose()
//        //                    }
//        //                }
//        //            }
//        //            .padding()
//        
//        VStack(alignment: .leading, spacing: 20) {
//            Text("Answer the survey to see your community health dashboard")
//                .multilineTextAlignment(.center)
//            
//            Text(questions[currentQuestionIndex].text)
//                .bold()
//            
//            // Check the question type and render the appropriate UI
//            if questions[currentQuestionIndex].type == .slider {
//                Slider(value: Binding(
//                    get: { Double(selectedSliderAnswer) },
//                    set: { selectedSliderAnswer = Int($0.rounded())
//                    }),
//                       in: Double(1)...Double(5), step: 1.0)
//                HStack {
//                    ForEach(range, id: \.self) { number in
//                        Text("\(number)     ").tag(number)
//                    }
//                }
//                .padding(.leading, 20)
//            } else if questions[currentQuestionIndex].type == .multipleChoice {
//                let mcIndex = currentQuestionIndex - 5 // Adjust based on the number of slider questions
//                Picker("", selection: $selectedMCAnswer[mcIndex]) {
//                    ForEach(0..<mcAnswers.count, id: \.self) { index in
//                        Text(mcAnswers[index]).tag(index)
//                    }
//                }
//                .pickerStyle(SegmentedPickerStyle())
//            }
//            
//            HStack {
//                Button("Next", action: goToNextQuestion)
//                    .disabled(currentQuestionIndex >= questions.count - 1)
//            }
//        }
//        .padding()
//    }
//    private func goToNextQuestion() {
//        
//        if currentQuestionIndex < questions.count - 1 {
//            currentQuestionIndex += 1
//            // Reset selected answer for the next question based on type
//            if questions[currentQuestionIndex].type == .slider {
//                selectedSliderAnswer = 0 // or your default value for slider questions
//                //            } else {
//                //                selectedMCAnswer[currentQuestionIndex] = 0 // default to first option for MC questions
//                //            }
//            } else {
//                onClose() // All questions have been answered, close the survey
//            }
//        }
//    }
//}
