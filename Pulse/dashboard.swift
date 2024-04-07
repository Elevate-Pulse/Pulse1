//
//  dashboard.swift
//  Pulse
//
//  Created by Yinglin Jiang on 3/19/24.
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
                .fill(label == "last week" ? Color.gray : Color.black)
                .frame(width: 20, height: value)
            Text(label)
                .font(.caption)
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
            HStack {
                Bar(value: (Q1_ans1 /*/ maxValue) * 100*/), label: "a1")
                Bar(value: (Q1_ans2 /*/ maxValue) * 100*/), label: "a2")
                Bar(value: (Q1_ans3 /*/ maxValue) * 100*/), label: "a3")
                Bar(value: (Q1_ans4 /*/ maxValue) * 100*/), label: "a4")
                Bar(value: (Q1_ans5 /*/ maxValue) * 100*/), label: "a5")
            }
//            .padding(.bottom)
//            Text("residents think that it's safer than the last week")
//                .font(.caption)
//                .multilineTextAlignment(.center)
        }
        .padding()
        .background(Color.white)
        .frame(width: 280, height: 230)
        .cornerRadius(50)
        .shadow(radius: 5)
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

struct dashboard: View {
    
    @State private var questionsData: [QuestionData] = []
    @State private var answerCounts: [(a1: Int, a2: Int, a3: Int, a4: Int, a5: Int)] = []
    
    var body: some View {
        
        VStack {
            ZStack {
                ScrollView {
                    Text("Your community health check")
                        .bold()
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
                    .padding()
                    
                    DonutChartView()
                }
            }
        } .onAppear {
            Task {
                await pullData(questionID: "question1", title: "Question 1 Title")
                await pullData(questionID: "question2", title: "Question 2 Title")
                await pullData(questionID: "question3", title: "Question 3 Title")
                await pullData(questionID: "question4", title: "Question 4 Title")
                await pullData(questionID: "question5", title: "Question 5 Title")
            }
        }
    }
    
    
    func pullData(questionID: String, title: String) async {
        var countsForQuestion: (a1: Int, a2: Int, a3: Int, a4: Int, a5: Int) = (0, 0, 0, 0, 0)
        var totalAnswersCount = 0
        
        for answer in 1...5 {
            let count = try? await getCount(question: questionID, answer: answer)
            totalAnswersCount += count ?? 0
            switch answer {
            case 1:
                countsForQuestion.a1 = count ?? 0
            case 2:
                countsForQuestion.a2 = count ?? 0
            case 3:
                countsForQuestion.a3 = count ?? 0
            case 4:
                countsForQuestion.a4 = count ?? 0
            case 5:
                countsForQuestion.a5 = count ?? 0
            default:
                break
            }
        }
        
        if totalAnswersCount > 0 {
            let percentages = (
                a1: (countsForQuestion.a1 * 100) / totalAnswersCount,
                a2: (countsForQuestion.a2 * 100) / totalAnswersCount,
                a3: (countsForQuestion.a3 * 100) / totalAnswersCount,
                a4: (countsForQuestion.a4 * 100) / totalAnswersCount,
                a5: (countsForQuestion.a5 * 100) / totalAnswersCount
            )
            let questionData = QuestionData(title: title, a1: percentages.a1, a2: percentages.a2, a3: percentages.a3, a4: percentages.a4, a5: percentages.a5)
            DispatchQueue.main.async {
                self.questionsData.append(questionData)
            }
        }
    }

    func getCount(question: String, answer: Int) async -> Int {
        var count: Int = 0
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
        
        return count
    }

}
    
#Preview {
    dashboard()
}

