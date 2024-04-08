//
//  newDashboard.swift
//  Pulse
//
//  Created by Yinglin Jiang on 4/7/24.
//

import SwiftUI
import Charts
import Firebase
import FirebaseFirestore

struct Bar: View {
    var value: CGFloat
    var label: String
    
    var body: some View {
        VStack {
            Spacer()
            Rectangle()
                .fill(colorForLabel(label))
                .frame(width: 20, height: value)
            Text(label)
                .font(.caption)
        }
    }
    
    private func colorForLabel(_ label: String) -> Color {
        switch label {
        case "1":
            return Color("yellow_c")
        case "2":
            return Color("blue_c")
        case "3":
            return Color("purple_c")
        case "4":
            return Color("peach")
        case "5":
            return Color("light_green")
        default:
            return Color.gray // Fallback color
        }
    }
}
struct CardView: View {
    var Q1_ans1: CGFloat
    var Q1_ans2: CGFloat
    var Q1_ans3: CGFloat
    var Q1_ans4: CGFloat
    var Q1_ans5: CGFloat
    var title: String
    
    private let maxValue: CGFloat = 100
    
    var body: some View {
        VStack {
            Text("\(title)")
                .bold()
                .font(Font.custom("Comfortaa-Light", size: 10))
            HStack {
                Bar(value: (Q1_ans1 /*/ maxValue) * 100*/), label: "1")
                Bar(value: (Q1_ans2 /*/ maxValue) * 100*/), label: "2")
                Bar(value: (Q1_ans3 /*/ maxValue) * 100*/), label: "3")
                Bar(value: (Q1_ans4 /*/ maxValue) * 100*/), label: "4")
                Bar(value: (Q1_ans5 /*/ maxValue) * 100*/), label: "5")
            }
//            .padding(.bottom)
//            Text("residents think that it's safer than the last week")
//                .font(.caption)
//                .multilineTextAlignment(.center)
        }
        .padding()
        .background(Color.white)
        .frame(width: 180, height: 230)
        .cornerRadius(30)
        .shadow(radius: 2)
    }
}
struct QuestionData {
    let title: String
    var a1: Int
    var a2: Int
    var a3: Int
    var a4: Int
    var a5: Int
}
struct newDashboard: View {
    
    @State private var questionsData: [QuestionData] = []
    @State private var answerCounts: [(a1: Int, a2: Int, a3: Int, a4: Int, a5: Int)] = []
    
    var body: some View {
        
        VStack {
            ZStack {
                ScrollView {
                    Text("Your community health check")
                        .bold()
                        .font(Font.custom("Comfortaa-Light", size: 20))
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(0..<questionsData.count, id: \.self) { index in
                            let question = questionsData[index]
                            CardView(Q1_ans1: CGFloat(question.a1),
                                     Q1_ans2: CGFloat(question.a2),
                                     Q1_ans3: CGFloat(question.a3),
                                     Q1_ans4: CGFloat(question.a4),
                                     Q1_ans5: CGFloat(question.a5),
                                     title: question.title)
                        }
                    }
                    .padding([.horizontal, .top])
                    
                    Spacer(minLength: 50)
                    Text("Personality Types")
                        .bold()
                        .font(Font.custom("Comfortaa-Light", size: 20))
                    Spacer(minLength: 70)
                    
                    
                    DonutChartView()
                }
            }
        } 
        .background(Color("cream"))
        .onAppear {
            Task {
//                await pullData(questionID: "question1", title: "Question 1 Title")
//                await pullData(questionID: "question2", title: "Question 2 Title")
//                await pullData(questionID: "question3", title: "Question 3 Title")
//                await pullData(questionID: "question4", title: "Question 4 Title")
//                await pullData(questionID: "question5", title: "Question 5 Title")
                await pullData()
            }
        }
    }
    
    
    func pullData() async {
        
        let fs = Firestore.firestore()
        let surveyResponses = fs.collection("survey_responses")

        var questionAnswers: [String: [Int]] = [:]

        do {
            let snapshot = try await surveyResponses.getDocuments()

            // Initialize the dictionary to store answer counts for each question
            for questionID in 1...5 { // Assuming 5 questions
                questionAnswers["question\(questionID)"] = [0, 0, 0, 0, 0] // 5 answer choices
            }

            // Tally the answers for each question
            for document in snapshot.documents {
                let data = document.data()
                for questionID in 1...5 {
                    if let answer = data["question\(questionID)"] as? Int, answer >= 1 && answer <= 5 {
                        questionAnswers["question\(questionID)"]?[answer - 1] += 1
                    }
                }
            }
            let q_s: [String] = [
                "Do you feel a sense of community living in your neighborhood? \n(1 = Strongly disagree, 5 = Strongly agree)",
                
                "I feel safe walking alone in my neighborhood at night \n(1 = Strongly disagree, 5 = Strongly agree)",
                
                "Accessing daily necessities (groceries, healthcare, etc.) within the neighborhood or by public transportation is easy \n(1 = Strongly disagree, 5 = Strongly agree)",
                
                "Would you recommend anyone to move to the neighborhood? \n(1 = Strong no, 5 = Strong yes)",
                
                "The streets and parks in my neighborhood are well-maintained and visually appealing \n(1 = Strongly disagree, 5 = Strongly agree"
            ]

            // Convert counts to percentages and prepare for UI
            var uiData: [QuestionData] = []
            for questionID in 1...5 {
                if let answers = questionAnswers["question\(questionID)"] {
                    let totalAnswers = answers.reduce(0, +)
                    if totalAnswers > 0 {
                        let percentages = answers.map { CGFloat($0 * 100 / totalAnswers) }
                        uiData.append(QuestionData(
                            title: "\(q_s[questionID-1])",
                            a1: Int(percentages[0]),
                            a2: Int(percentages[1]),
                            a3: Int(percentages[2]),
                            a4: Int(percentages[3]),
                            a5: Int(percentages[4])
                        ))
                    }
                }
            }

            // Update UI
            DispatchQueue.main.async {
                self.questionsData = uiData
            }
        } catch {
            print("Error fetching survey responses: \(error.localizedDescription)")
        }
    
    }
}

#Preview{
    newDashboard()
}
