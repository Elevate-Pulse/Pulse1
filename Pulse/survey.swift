//
//  survey.swift
//  Pulse
//
//  Created by Yinglin Jiang on 3/19/24.
//

import SwiftUI

struct SurveyQuestionView: View {
    @Binding var selectedAnswer: Int
    @State private var currentQuestionIndex = 0
    let questions: [String]
    let range: ClosedRange<Int>
    let onClose: () -> Void
    
    // Use a local variable to bind to the slider as a Double
        private var sliderValue: Binding<Double> {
            Binding<Double>(
                get: { Double(selectedAnswer) },
                set: { selectedAnswer = Int($0.rounded())
//                    print("Selected answer: ", selectedAnswer)
                }
                
            )
        }

        private func goToNextQuestion() {
            if currentQuestionIndex < questions.count - 1 {
//                print("Selected answer: ", selectedAnswer)
                currentQuestionIndex += 1
                selectedAnswer = range.lowerBound // Reset selected answer for the next question
            } else {
                onClose() // All questions have been answered, close the survey
            }
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Text("Answer the survey to see your community health dashboard")
                    .multilineTextAlignment(.center)
                Text(questions[currentQuestionIndex])
                    .bold()
                Slider(value: sliderValue, in: Double(range.lowerBound)...Double(range.upperBound), step: 1.0)
                HStack {
                    ForEach(range, id: \.self) { number in
                        Text("\(number)             ").tag(number)
                    }
                    .padding(.leading, 27)
                }
                
                HStack {
                    Button("Next") {
                        goToNextQuestion()
//                        print("selected answer: ", selectedAnswer)
                    }
                    .disabled(currentQuestionIndex >= questions.count - 1) // Disable "Next" if this is the last question

                    Button("Close") {  // This button will close the popup
                        onClose()
                    }
                }
            }
            .padding()
        }
}

#Preview {
    SurveyQuestionView(selectedAnswer: .constant(0), // Example binding to selected answer
                       questions: ["Question 1", "Question 2", "Question 3"], // Example array of questions
                       range: 1...5, // Example range of possible answers
                       onClose: {}) // Example closure for onClose
}

