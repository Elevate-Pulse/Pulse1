//
//  survey.swift
//  Pulse
//
//  Created by Yinglin Jiang on 3/19/24.
//

import SwiftUI

struct SurveyQuestionView: View {
    @Binding var selectedAnswer: Int
    let question: String
    let range: ClosedRange<Int>
    // Use a local variable to bind to the slider as a Double
    private var sliderValue: Binding<Double> {
        Binding<Double>(
            get: { Double(selectedAnswer) },
            set: { selectedAnswer = Int($0.rounded()) }
        )
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Answer the survey to see your community health dashboard")
            Text(question)
                .bold()
            Slider(value: sliderValue, in: Double(range.lowerBound)...Double(range.upperBound), step: 1.0)
            HStack {
                ForEach(range, id: \.self) { number in
                    Text("\(number)                 ").tag(number)
                }
            }
            Button("Next") {
                //to go to next question
            }
        }
        .padding()
    }
}

