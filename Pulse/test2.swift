////
////  test2.swift
////  Pulse
////
////  Created by Yinglin Jiang on 4/7/24.
////
//
//import SwiftUI
//
//struct test2: View {
//    @State private var currentQuestionIndex = 0
//    
//    @State private var selectedSliderAnswers: [Int] = Array(repeating: 3, count: 5) // Assuming 5 slider questions
//
//    // State for the multiple-choice answers, one for each question
//    @State private var selectedMCAnswers: [Int] = Array(repeating: 0, count: 5) // Assuming 5 multiple-choice questions
//
//    // Combine your slider and multiple-choice questions into one array
//    let questions: [SurveyQuestion] = [
//        // Your 5 original slider-based questions
//        SurveyQuestion(id: 0, text: "How supported do you feel on a scale?", type: .slider, answers: nil),
//        SurveyQuestion(id: 1, text: "Do you feel safe in your community on a scale?", type: .slider, answers: nil),
//        SurveyQuestion(id: 2, text: "Do you like your community on a scale?", type: .slider, answers: nil),
//        SurveyQuestion(id: 3, text: "Would you recommend anyone live in the neighborhood on a scale?", type: .slider, answers: nil),
//        SurveyQuestion(id: 4, text: "Level of happiness on a scale?", type: .slider, answers: nil),
//
//        // Your 5 new multiple-choice questions
//        SurveyQuestion(id: 5, text: "Which best describes your living situation?", type: .multipleChoice, answers: ["Open-minded", "Private", "Outgoing", "Engaged", "Easygoing"]),
//        SurveyQuestion(id: 6, text: "Something scenario?", type: .multipleChoice, answers: ["Open-minded", "Private", "Outgoing", "Engaged", "Easygoing"]),
//        SurveyQuestion(id: 7, text: "Another scenario?", type: .multipleChoice, answers: ["Open-minded", "Private", "Outgoing", "Engaged", "Easygoing"]),
//        SurveyQuestion(id: 8, text: "Fourth scenario?", type: .multipleChoice, answers: ["Open-minded", "Private", "Outgoing", "Engaged", "Easygoing"]),
//        SurveyQuestion(id: 9, text: "fifth scenario", type: .multipleChoice, answers: ["Open-minded", "Private", "Outgoing", "Engaged", "Easygoing"])
//        ]
//    
//        private func closeSurvey() {
////            showPopup = false
//    //        self.currentQuestionIndex = 0 // Reset the survey for next time it's shown
//    //        self.selectedSliderAnswers = 1 // Reset the selected answer
//        }
//        
//        var body: some View{
//            SurveyQuestionView(selectedSliderAnswers: $selectedSliderAnswers,
//                               selectedMCAnswer: $selectedMCAnswers,
//                               questions: questions,
//                               onClose: closeSurvey,
//                               range: 1...5)
//        }
//        
//}
//
//#Preview {
//    test2()
//}
