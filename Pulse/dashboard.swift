import SwiftUI

struct dashboard: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var showPopup = true
    @State private var currentQuestionIndex = 0

    let data = [
        (lastWeek: 50, thisWeek: 70),
        (lastWeek: 80, thisWeek: 40),
        (lastWeek: 30, thisWeek: 90),
        (lastWeek: 60, thisWeek: 60)
    ]
    
    @State private var selectedSliderAnswers: [Int] = Array(repeating: 3, count: 5)
    @State private var selectedMCAnswers: [Int] = Array(repeating: 0, count: 5)
    
    let questions: [SurveyQuestion] = [
        SurveyQuestion(id: 0, text: "Do you feel a sense of community living in your neighborhood? (1 = Strongly disagree, 5 = Strongly agree)", type: .slider, answers: nil),
        SurveyQuestion(id: 1, text: "I feel safe walking alone in my neighborhood at night (1 = Strongly disagree, 5 = Strongly agree)", type: .slider, answers: nil),
        SurveyQuestion(id: 2, text: "Accessing daily necessities (groceries, healthcare, etc.) within the neighborhood or by public transportation is easy (1 = Strongly disagree, 5 = Strongly agree)", type: .slider, answers: nil),
        SurveyQuestion(id: 3, text: "Would you recommend anyone to move to the neighborhood? (1 = Strong no, 5 = Strong yes)", type: .slider, answers: nil),
        SurveyQuestion(id: 4, text: "The streets and parks in my neighborhood are well-maintained and visually appealing (1 = Strongly disagree, 5 = Strongly agree", type: .slider, answers: nil),
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
                                 
                                 "I prefer to maintain my privacy and security on my own",
                                 
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
        presentationMode.wrappedValue.dismiss() // Dismiss the dashboard view
    }
    
    var body: some View {
        ZStack {
            if showPopup {
                Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
                SurveyQuestionView(selectedSliderAnswers: $selectedSliderAnswers,
                                   selectedMCAnswer: $selectedMCAnswers,
                                   questions: questions,
                                   onClose: closeSurvey,
                                   range: 1...5)
                    .background(Color(red: 1.0, green: 0.996, blue: 0.953))
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    .padding()
                    .transition(.move(edge: .bottom))
                    .animation(.spring(), value: showPopup)
            }
        }
        .accentColor(Color(red: 35/255, green: 109/255, blue: 97/255))
        .onAppear {
            showPopup = true
        }
    }
}

struct dashboard_Previews: PreviewProvider {
    static var previews: some View {
        dashboard()
            .environmentObject(AuthViewModel())
    }
}
