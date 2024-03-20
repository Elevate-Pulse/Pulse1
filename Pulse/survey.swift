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
                set: { selectedAnswer = Int($0.rounded()) }
            )
        }

        private func goToNextQuestion() {
            if currentQuestionIndex < questions.count - 1 {
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
                        Text("\(number)").tag(number)
                    }
                }
                
                HStack {
                    Button("Next") {
                        goToNextQuestion()
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

