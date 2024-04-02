//
//  dashboard.swift
//  Pulse
//
//  Created by Yinglin Jiang on 3/19/24.
//

import SwiftUI
import Charts

struct Bar: View {
    var value: CGFloat
    var label: String
    
    var body: some View {
        VStack {
            Spacer()
            Rectangle()
                .fill(label == "last week" ? Color.gray : Color.black)
                .frame(width: 30, height: value)
//                .padding(.bottom)
            Text(label)
                .font(.caption)
        }
    }
}
struct CardView: View {
    var lastWeekValue: CGFloat
    var thisWeekValue: CGFloat
    
    private let maxValue: CGFloat = 100
    
    var body: some View {
        VStack {
            Text("Safety")
                .bold()
            HStack {
                Bar(value: (lastWeekValue / maxValue) * 100, label: "last week")
                Bar(value: (thisWeekValue / maxValue) * 100, label: "this week")
            }
            .padding(.bottom)
            Text("residents think that it's safer than the last week")
                .font(.caption)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}
struct dashboard: View {
    @State var selectedAnswer = 1 // Default answer to start wit
    @State private var showPopup = true
    @State private var currentQuestionIndex = 0
    let questions: [String] = [
        "On a scale of 1 to 5, how supported do you feel by local government or community organizations in addressing any issues or concerns you may have?",
        "How would you rate your likelihood to recommend living in this area to others from 1 (not likely) to 5 (very likely)?",
        "On a scale of 1 to 5, how strong is your sense of belonging and community in your area?",
        "On a scale of 1 (very unsafe) - 5 (very safe), how safe do you feel in your neighborhood?",
        "On a scale of 1 to 5, how satisfied are you with your current living situation?",
        "How are you feeling today?",
        "Rate the overall quality of life in your neighborhood on a scale of 1 to 5",
        "How would you rate the overall challenges or concerns you've encountered in your living situation in this area from 1 to 5?"
    ]
    let range: ClosedRange<Int> = 1...5
    // Dummy data for the bar values
    let data = [
        (lastWeek: 50, thisWeek: 70),
        (lastWeek: 80, thisWeek: 40),
        (lastWeek: 30, thisWeek: 90),
        (lastWeek: 60, thisWeek: 60)
    ]
    
    private func closeSurvey() {
        self.showPopup = false
        self.currentQuestionIndex = 0 // Reset the survey for next time it's shown
        self.selectedAnswer = 1 // Reset the selected answer
    }
    
    var body: some View {
        
        ZStack {
            ScrollView {
                Text("Your community health check")
                    .bold()
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(data.indices, id: \.self) { index in
                        CardView(lastWeekValue: CGFloat(data[index].lastWeek),
                                 thisWeekValue: CGFloat(data[index].thisWeek))
                    }
                }
                .padding()
            }
            .blur(radius: showPopup ? 3 : 0)
            
            if showPopup {
                Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
            }
                
            if showPopup {
                SurveyQuestionView(selectedAnswer: $selectedAnswer,
                                   questions: questions,
                                   range: range,
                                   onClose: closeSurvey)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    .padding()
                    .transition(.move(edge: .bottom))
                    .animation(.spring(), value: showPopup)
            }

        }
        .onAppear {
            // Show the survey popup when the view appears
            self.showPopup = true
        }
    }
}

#Preview {
    dashboard()
}

