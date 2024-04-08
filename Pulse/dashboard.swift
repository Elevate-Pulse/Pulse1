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
//    @State var selectedAnswer = 1 // Default answer to start wit
    @State private var showPopup = true
    @State private var currentQuestionIndex = 0
//    let questions: [String] = [
//        "On a scale of 1 to 5, how supported do you feel by local government or community organizations in addressing any issues or concerns you may have?",
//        "How would you rate your likelihood to recommend living in this area to others from 1 (not likely) to 5 (very likely)?",
//        "On a scale of 1 to 5, how strong is your sense of belonging and community in your area?",
//        "On a scale of 1 (very unsafe) - 5 (very safe), how safe do you feel in your neighborhood?",
//        "On a scale of 1 to 5, how satisfied are you with your current living situation?",
//        "How are you feeling today?",
//        "Rate the overall quality of life in your neighborhood on a scale of 1 to 5",
//        "How would you rate the overall challenges or concerns you've encountered in your living situation in this area from 1 to 5?"
//    ]
//    let range: ClosedRange<Int> = 1...5
//    // Dummy data for the bar values
    let data = [
        (lastWeek: 50, thisWeek: 70),
        (lastWeek: 80, thisWeek: 40),
        (lastWeek: 30, thisWeek: 90),
        (lastWeek: 60, thisWeek: 60)
    ]
    
    @State private var selectedSliderAnswers: [Int] = Array(repeating: 3, count: 5) // Assuming 5 slider questions
    // State for the multiple-choice answers, one for each question
    @State private var selectedMCAnswers: [Int] = Array(repeating: 0, count: 5) // Assuming 5 multiple-choice questions
    // Combine your slider and multiple-choice questions into one array
    let questions: [SurveyQuestion] = [
        // Your 5 original slider-based questions
        SurveyQuestion(id: 0, text: "I feel a sense of community living in my neighborhood \n(1 = Strongly disagree, 5 = Strongly agree)", type: .slider, answers: nil),
        SurveyQuestion(id: 1, text: "I feel safe walking alone in my neighborhood at night \n(1 = Strongly disagree, 5 = Strongly agree)", type: .slider, answers: nil),
        SurveyQuestion(id: 2, text: "Accessing daily necessities (groceries, healthcare, etc.) within the neighborhood or by public transportation is easy \n(1 = Strongly disagree, 5 = Strongly agree)", type: .slider, answers: nil),
        SurveyQuestion(id: 3, text: "Would you recommend anyone to move to the neighborhood? \n(1 = Strong no, 5 = Strong yes)", type: .slider, answers: nil),
        SurveyQuestion(id: 4, text: "The streets and parks in my neighborhood are well-maintained and visually appealing \n(1 = Strongly disagree, 5 = Strongly agree", type: .slider, answers: nil),
        // Your 5 new multiple-choice questions
        SurveyQuestion(id: 5, text: "You’re leaving to work for the day, walking to your car, and you see your new nextdoor neighbor, what do you do?", type: .multipleChoice,
                       answers: ["Good morning, [Neighbor's Name]! Anything exciting planned for today?",
                                 
                                 "We haven’t spoken much, maybe I'll introduce myself today.",
                                 
                                 "Give a small wave if you make eye contact",
                                 
                                 "Have a nice day! Is there anything you need help with around the neighborhood?",
                                 "Offer a friendly smile and a simple “Hello”"]),
        
        SurveyQuestion(id: 6, text: "You're driving to work and see a sign for a new fast food chain restaurant opening. How do you feel?", type: .multipleChoice,
                       answers: ["Ooh, a new place to try! Maybe I can grab lunch with some friends when it opens.",
                                 
                                 "A new restaurant! I’ll have to try it out.",
                                 
                                 "Another fast food place? Not really my thing. I prefer to cook at home",
                                 "Hmm, I wonder if this will affect local businesses or traffic flow in the area.",
                                 
                                 "(Barely notices the sign, continues driving)"]),
        
        SurveyQuestion(id: 7, text: "You read a flier that a new community building has opened nearby. How do you respond?", type: .multipleChoice,
                       answers: ["Wow, this could be great! I’ll check if it has the gym/pool/library I’ve been looking for. Maybe it’s a chance to meet more people!",
                                 
                                 "Interesting, I'll have to see what amenities they offer. It’s always good to have more options nearby.",
                                 
                                 "As long as it doesn’t get too crowded or noisy, it’s fine by me.",
                                 
                                 "New amenities could be beneficial. I should see if they align with community needs and sustainability goals",
                                 
                                 "Neat, might check it out if I remember. More amenities could be handy."]),
        
        SurveyQuestion(id: 8, text: "There’s been crime happening near your neighborhood. How do you respond?", type: .multipleChoice,
                       answers: ["Safety first! I’ll see if there’s a neighborhood watch or a new security system I can join or recommend.",
                                 
                                 "Security is important. Maybe there’s an innovative or community-driven solution to explore.",
                                 
                                 " prefer to maintain my privacy and security on my own",
                                 
                                 "Community safety is key. I wonder if there are meetings or initiatives I can participate in to help improve it.",
                                 
                                 "Hope everyone’s doing their part to keep the neighborhood safe. I’ll keep an eye out."]),
        
        SurveyQuestion(id: 9, text: "When you get home from work, you see a flier taped to your door inviting you to a community event that the alderman is hosting this weekend. Are you going?", type: .multipleChoice,
                       answers: ["Absolutely going! It’s a perfect opportunity to connect with neighbors and discuss community issues.",
                                 
                                 "I’m curious about what will be discussed. Attending could be a great way to learn more about the community.",
                                 
                                 "Maybe I’ll go, if it seems like it won’t be too crowded. It's good to stay informed, even if I keep to myself",
                                 
                                 "Definitely. It’s important to be involved in community decisions and understand what’s happening in the neighborhood.",
                                 
                                 "Sounds like it could be interesting. If I’m free, I’ll check it out. Nice to see what’s going on in the community."])
        
    ]
    private func closeSurvey() {
        showPopup = false
//        self.currentQuestionIndex = 0 // Reset the survey for next time it's shown
//        self.selectedSliderAnswers = 1 // Reset the selected answer
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
                SurveyQuestionView(selectedSliderAnswers: $selectedSliderAnswers,
                                   selectedMCAnswer: $selectedMCAnswers,
                                   questions: questions,
                                   onClose: closeSurvey,
                                   range: 1...5)
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
            showPopup = true
        }
    }
}
#Preview{
    dashboard()
}
