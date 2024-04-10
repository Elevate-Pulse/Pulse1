//
//  HomeView1.swift
//  Pulse
//
//  Created by Peter Guan on 4/5/24.
//a
//.foregroundColor(Color(red: 28/255, green: 21/255, blue: 21/255)) <-- black
//.foregroundColor(Color(red: 35/255, green: 109/255, blue: 97/255)) <-- pulse green
//.foregroundColor(Color(red: 1.0, green: 0.996, blue: 0.953)) <-- cream
//.foregroundColor(Color(red: 88/255, green: 111/255, blue: 124/255)) <-- gray




import SwiftUI
import Firebase
import FirebaseFirestore

struct DataItem: Identifiable {
    var id = UUID()
    var title: String
    var size: CGFloat
    var color: Color
    var offset = CGSize.zero
    var level: Int
}

struct HomeView1: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var isExpanded = true
    @State private var shouldRefreshData = false
    // Define a state variable to track whether the dashboard view should be presented
    @State private var isDashboardActive = false
    @State private var neighborPercentage = 0
    @State private var isStrengthsWeaknessesExpanded = false
    // Define a state variable to hold the calculated personality type
    @State private var personalityType = "Undetermined"
    let personalityTraits: [String: (strengths: [String], weaknesses: [String])] = [
            "Outgoing Spirit": (strengths: ["Enthusiastic", "Social", "Builds strong relationships"],
                                weaknesses: ["Can be overly optimistic", "Might prioritize social activities over individual needs", "May struggle with solitude"]),
            "Open-Minded Explorer": (strengths: ["Adaptable", "Curious", "Appreciates diverse perspectives"],
                                     weaknesses: ["Might struggle with commitment", "Can be easily distracted by new ideas", "May lack focus on immediate needs"]),
            "Private Resident": (strengths: ["Independent", "Self-sufficient", "Values privacy"],
                                 weaknesses: ["Might miss out on community benefits", "Can be seen as aloof or unfriendly", "May lack a sense of belonging"]),
            "Engaged Citizen": (strengths: ["Responsible", "Passionate about improvement", "Advocates for change"],
                                weaknesses: ["Can be overly critical", "Might become overwhelmed by issues", "May struggle to delegate tasks"]),
            "Easygoing Neighbor": (strengths: ["Peaceful", "Avoids conflict", "Appreciates a calm environment"],
                                   weaknesses: ["Might struggle to take action", "May prioritize personal peace above community needs", "Could lack assertiveness"])
        ]
    let personalityTraitsSummary: [String: String] = [
        "Outgoing Spirit": "forge community through social connections.",
        "Open-Minded Explorer": "embrace diversity to enrich the neighborhood.",
        "Private Resident": "value solitude and privacy foremost.",
        "Engaged Citizen": "actively work for community betterment.",
        "Easygoing Neighbor": "promote peace and tranquility in their surroundings."
    ]

    var body: some View {
        let userName = viewModel.currentUser?.name ?? "Guest"
        NavigationView { // Move the NavigationView here
            VStack(spacing: 0) {
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("\(userName), you are \(personalityType.starts(with: ["A", "E", "I", "O", "U"]) ? "a" : "an")")
                                    .font(.custom("Comfortaa-Regular", size: 18))
                                    .foregroundColor(Color(red: 28/255, green: 21/255, blue: 21/255))
                                
                                Text(personalityType) // Display the calculated personality type
                                    .font(.custom("Comfortaa-Bold", size: 21))
                                    .foregroundColor(Color(red: 35/255, green: 109/255, blue: 97/255))
                            }
                            .padding(.top, 100)
                            Spacer()
                            VStack {
                                // Your other screen content here
                                Button(action: {
                                    // Set the state variable to true to activate the navigation link
                                    self.isDashboardActive = true
                                }) {
                                    Text("Retake Survey")
                                        .foregroundColor(Color(red: 35/255, green: 109/255, blue: 97/255))
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 10)
                                        .font(.custom("Comfortaa-Regular", size: 15))
                                        .background(
                                            RoundedRectangle(cornerRadius: 25)
                                                .foregroundColor(Color(red: 1.0, green: 0.996, blue: 0.953))
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 25)
                                                        .stroke(Color(red: 35/255, green: 109/255, blue: 97/255), lineWidth: 2)
                                                )
                                        )
                                }
                                // Use the NavigationLink to conditionally navigate to the dashboard view
                                NavigationLink(destination: dashboard(), isActive: $isDashboardActive) {
                                    
                                }
                            }
                            .padding(.top, 100)
                        }
                        Text("Just like \(neighborPercentage)% of your neighbors")
                            .font(.custom("Comfortaa-Regular", size: 18))
                            .foregroundColor(Color(red: 28/255, green: 21/255, blue: 21/255))
                        Text("\(personalityType)s \(personalityTraitsSummary[personalityType] != nil ? personalityTraitsSummary[personalityType]! : "")")
                            .font(.custom("Comfortaa-Regular", size: 18))
                            .foregroundColor(Color(red: 28/255, green: 21/255, blue: 21/255))

                        StrengthsWeaknessesSection(isExpanded: $isStrengthsWeaknessesExpanded, personalityType: personalityType, strengths: personalityTraits[personalityType]?.strengths ?? [], weaknesses: personalityTraits[personalityType]?.weaknesses ?? [])
                        Text("Weekly Goals")
                            .font(.custom("Comfortaa-Bold", size: 21))
                            .foregroundColor(Color(red: 28/255, green: 21/255, blue: 21/255))
                            .padding(.top, 10) // Add some top padding
                        GoalsView()
                        Text("Your dominant character trait is:")
                            .font(.custom("Comfortaa-Regular", size: 21))
                            .foregroundColor(Color(red: 28/255, green: 21/255, blue: 21/255))
                        Text(personalityType) // Display the calculated personality type
                            .font(.custom("Comfortaa-Bold", size: 21))
                            .foregroundColor(Color(red: 35/255, green: 109/255, blue: 97/255))
                            .padding(.bottom, CGFloat(Circles().data.map { $0.size }.min() ?? 120))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    .padding(.top, -36)
                    
                    Circles()
                        .frame(height: 175)// Placing Circles view here
                    Text("space filler")
                        .font(.custom("Comfortaa-Bold", size: 75))
                        .foregroundColor(Color(red: 1.0, green: 0.996, blue: 0.953))
                        .opacity(0)
                }
                .background(Color(red: 1.0, green: 0.996, blue: 0.953))
                .edgesIgnoringSafeArea(.all)
            }
            .navigationBarBackButtonHidden(true)
            .onAppear {
                            Task {
                                await fetchCurrentUserPersonalityType()
                                await calculateNeighborPercentage()
                            }
                        }
                    }
                }
    private func fetchCurrentUserPersonalityType() async {
            guard let userID = viewModel.currentUser?.id else {
                print("Error: Current user ID not available")
                return
            }
            
            let db = Firestore.firestore()
            
            do {
                let querySnapshot = try await db.collection("survey_responses")
                    .whereField("userID", isEqualTo: userID)
                    .getDocuments()
                
                if let document = querySnapshot.documents.first {
                    if let personalityType = document.data()["personalityType"] as? String {
                        self.personalityType = personalityType
                    } else {
                        print("Personality type not found for user ID: \(userID)")
                    }
                } else {
                    print("Document not found for user ID: \(userID)")
                }
            } catch {
                print("Error fetching documents: \(error)")
            }
        }

        private func calculateNeighborPercentage() async {
            let db = Firestore.firestore()
            
            do {
                let querySnapshot = try await db.collection("survey_responses")
                    .whereField("personalityType", isEqualTo: self.personalityType)
                    .getDocuments()
                
                let totalCount = querySnapshot.documents.count
                if totalCount == 0 {
                    self.neighborPercentage = 0
                } else {
                    let currentUserCount = totalCount > 0 ? 1 : 0
                    let percentage = Int(Double(totalCount - currentUserCount) / Double(totalCount) * 100)
                    self.neighborPercentage = percentage
                }
            } catch {
                print("Error fetching documents: \(error)")
            }
        }
    }
    


struct StrengthsWeaknessesSection: View {
    @Binding var isExpanded: Bool
    let personalityType: String
    let strengths: [String]
    let weaknesses: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button(action: {
                isExpanded.toggle()
            }) {
                HStack {
                    Text("Strengths and Weaknesses")
                        .font(.custom("Comfortaa-Bold", size: 21))
                        .foregroundColor(Color(red: 28/255, green: 21/255, blue: 21/255))
                    Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                        .foregroundColor(.black)
                }
            }
            if isExpanded {
                VStack {
                    StrengthWeakness(label: "Strengths", bulletTexts: strengths)
                    StrengthWeakness(label: "Weaknesses", bulletTexts: weaknesses)
                }
                .padding(.vertical, 15)
            }
        }
        .onDisappear {
            // Reset isExpanded state variable when leaving the view
            isExpanded = false
        }
    }
}


struct StrengthWeakness: View {
    var label: String
    var bulletTexts: [String]
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color(red: 35/255, green: 109/255, blue: 97/255))
                .frame(width: UIScreen.main.bounds.width - 40, height: 30)
                .overlay(
                    Text(label)
                        .font(.custom("Comfortaa-Regular", size: 15))
                        .foregroundColor(Color.white)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke((Color(red: 88/255, green: 111/255, blue: 124/255)), lineWidth: 1)
                )
            
            Rectangle()
                .fill(Color(red: 1.0, green: 0.996, blue: 0.953))
                .frame(width: UIScreen.main.bounds.width - 40, height: CGFloat(bulletTexts.count * 40) + 20) // Adjust height dynamically based on the number of bullet points
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke((Color(red: 88/255, green: 111/255, blue: 124/255)), lineWidth: 1)
                )
                .overlay(
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(bulletTexts, id: \.self) { bulletText in
                            HStack {
                                Circle()
                                    .fill(Color(red: 35/255, green: 109/255, blue: 97/255))
                                    .frame(width: 10, height: 10)
                                Text(bulletText)
                                    .foregroundColor(Color(red: 28/255, green: 21/255, blue: 21/255))
                                    .font(.custom("Comfortaa-Regular", size: 15))
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                )
        }
    }
}


struct Goal: View {
    var progress: Double
    var goalText: String
    var goalIdentifier: String // Add goal identifier property

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(goalText)
                .font(.custom("Comfortaa-Regular", size: 15))
                .foregroundColor(Color(red: 28/255, green: 21/255, blue: 21/255))
            ProgressBar(progress: progress, goalIdentifier: goalIdentifier) // Pass goal identifier to ProgressBar
        }
    }
}


struct ProgressBar: View {
    @State private var progress: Double
    @State private var showWaitMessage = false
    let goalIdentifier: String
    let goalProgressTest = GoalProgressTest()

    init(progress: Double, goalIdentifier: String) {
        self._progress = State(initialValue: progress)
        self.goalIdentifier = goalIdentifier
    }

    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        let progressBarWidth = screenWidth - 50

        return Button(action: {
            // Only increment progress if it's less than 1.0 (7/7)
            if self.progress < 1.0 {
                self.progress += 1.0 / 6.5
            } else {
                // Show the wait message if progress is already complete
                self.showWaitMessage = true
            }

            // Cap the progress to maximum 1.0 (7/7)
            if self.progress > 1.0 {
                self.progress = 1.0
            }

            // Call updateGoalProgress only if progress is not complete
            if self.progress < 1.0 {
                goalProgressTest.updateGoalProgress(progressNum: 1, goal: self.goalIdentifier)
            }
        }) {
            HStack(spacing: 30) {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: progressBarWidth - 50, height: 35)
                        .foregroundColor(Color(red: 0.9255, green: 0.9294, blue: 0.9451))

                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: CGFloat(self.progress) * (progressBarWidth - 50), height: 35)
                        .foregroundColor(Color(red: 35/255, green: 109/255, blue: 97/255))

                    Text(String(format: "%.0f/7", self.progress * 7))
                        .foregroundColor(Color(red: 35/255, green: 109/255, blue: 97/255))
                        .font(.custom("Comfortaa-Regular", size: 15))
                        .padding(.horizontal, 8)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .offset(x: CGFloat(self.progress) * (progressBarWidth - 50) - 15, y: -18)
                }

                if progress >= 1.0 && progress <= 7.0 {
                    // Checkmark image indicating progress complete
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(Color(red: 35/255, green: 109/255, blue: 97/255))
                        .font(.system(size: 24))
                } else {
                    // Plus image indicating progress can be incremented
                    Image(systemName: "plus.app")
                        .foregroundColor(Color(red: 35/255, green: 109/255, blue: 97/255))
                        .font(.system(size: 27))
                }
            }
        }
        .overlay(
            Group {
                if showWaitMessage {
                    MessageBubble()
                }
            }
        )
        .onAppear {
              // Fetch progress for the specific goal on appear
             
              }
    }
}


struct MessageBubble: View {
    @State private var isShowing = true

    var body: some View {
        let backgroundColor: Color = Color(red: 0.9255, green: 0.9294, blue: 0.9451)

        return VStack {
            Text("Please until next week for new goals")
                .font(.custom("Comfortaa-Regular", size: 15))
                .foregroundColor(Color(red: 28/255, green: 21/255, blue: 21/255))
                .padding(8)
                .background(backgroundColor)
                .cornerRadius(10)
                .opacity(isShowing ? 1.0 : 0.0) // Adjust opacity based on isShowing state
                .animation(.easeInOut(duration: 2)) // Fade animation
        }
        .padding(.top, -30)
        .padding(.trailing, 20)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .onAppear {
            // Start a timer to hide the message after 1 second
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                withAnimation {
                    isShowing = false
                }
            }
        }
    }
}


struct GoalsView: View {
    var body: some View {
        VStack(spacing: 15) {
            Goal(progress: 0/7, goalText: "Greet a neighbor", goalIdentifier: "goal1Progress") // Pass goal identifier
            Goal(progress: 0/7, goalText: "Go to your local library", goalIdentifier: "goal2Progress") // Pass goal identifier
            Goal(progress: 0/7, goalText: "Pick up a piece of trash", goalIdentifier: "goal3Progress") // Pass goal identifier
        }
    }
}


struct Circles: View {
    @State var data: [DataItem] = [
        DataItem(title: "👥 Social Environment", size: 90, color: Color(red: 186/255, green: 255/255, blue: 201/255), level: 0),
        DataItem(title: "🌳 Physical Environment", size: 90, color: Color(red: 161/255, green: 204/255, blue: 255/255), level: 0),
        DataItem(title: "🛠️ Amenities and Resources", size: 90, color: Color(red: 255/255, green: 194/255, blue: 168/255), level: 0),
        DataItem(title: "🔒 Safety and Security", size: 90, color: Color(red: 220/255, green: 185/255, blue: 255/255), level: 0),
        DataItem(title: "📢 Community Engagement", size: 90, color: Color(red: 255/255, green: 244/255, blue: 189/255), level: 0),
        
        /*
        DataItem(title: "🧑‍⚕️ Caretaker", size: 120, color: .green),
        DataItem(title: "🙋‍♂️ Volunteer", size: 120, color: .blue),
        DataItem(title: "📢 Activist", size: 120, color: .red),
        DataItem(title: "✌️ Peacemaker", size: 120, color: .pink),
        DataItem(title: "😊 Friend", size: 120, color: .yellow),
        */
        
        /*
        DataItem(title: "🧑‍⚕️ Caretaker", size: 60, color: .green),
        DataItem(title: "🙋‍♂️ Volunteer", size: 60, color: .blue),
        DataItem(title: "📢 Activist", size: 60, color: .red),
        DataItem(title: "✌️ Peacemaker", size: 60, color: .pink),
        DataItem(title: "😊 Friend", size: 60, color: .yellow),
        */
    ]
    let goalProgressTest = GoalProgressTest()
    var body: some View {
        VStack {
            ZStack {
                ForEach(data.indices, id: \.self) { index in
                    let item = data[index]
                    ZStack {
                        Circle()
                            .frame(width: CGFloat(item.size))
                            .foregroundColor(item.color)
                            .overlay(
                                Circle()
                                    .stroke(Color(red: 28/255, green: 21/255, blue: 21/255), lineWidth: 0.5)
                                    .opacity(0)
                            )
                        VStack(spacing: 1) { // Stack for emoji and level
                            Text(item.title.prefix(1))
                                .font(.custom("Comfortaa-Regular", size: item.size * 0.5))
                            Text("Lvl \(item.level)")
                                .font(.custom("Comfortaa-Regular", size: 15))
                        }
                    }
                    .offset(item.offset)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1).delay(Double(data.count - index) * 0.2)) {
                            data[index].offset = CGSize.zero
                        }
                    }
                }
            }
        }
        .onAppear {
            fetchLvls()
            reverseAnimation()
        }
    }
    
    func fetchLvls() {
            Task {
                do {
                    let lvls = try await goalProgressTest.getLvls() // Access getLvls through the instance
                    DispatchQueue.main.async {
                        updateLevels(goalProgress: lvls)
                    }
                } catch {
                    print("Error fetching goal progress: \(error)")
                }
            }
        }

        
        func updateLevels(goalProgress: [Int]) {
            // Assuming goalProgress array contains levels for each data item
            guard goalProgress.count == data.count else {
                print("Goal progress count does not match data count")
                return
            }
            
            for index in data.indices {
                data[index].level = goalProgress[index]
                print (goalProgress[index])
            }
        }
    
    func sortDataBySize() {
        data.sort(by: { $0.size > $1.size })
    }
    
    func calculateOffsets() {
        data[0].offset = CGSize.zero
        data[1].offset = CGSize(width: (data[0].size + data[1].size) / 2, height: 0 )
        
        var alpha = CGFloat.zero
        
        for i in 2..<data.count {
            let c = (data[0].size + data[i - 1].size) / 2
            let b = (data[0].size + data[i].size) / 2
            let a = (data[i - 1].size + data[i].size) / 2
            
            alpha += calculateAlpha(a, b, c)
            
            let x = cos(alpha) * b
            let y = sin(alpha) * b
            
            data[i].offset = CGSize(width: x, height: -y )
        }
    }
    
    func calculateAlpha(_ a: CGFloat, _ b: CGFloat, _ c: CGFloat) -> CGFloat {
        return acos(
            (pow(a, 2) - pow(b, 2) - pow(c, 2)) /
            (-10 * b * c)
        )
    }
    
    func increaseCaretakerSize() {
        if let caretakerIndex = data.firstIndex(where: { $0.title == "🧑‍⚕️ Caretaker" }) {
            data[caretakerIndex].size += 15
            let newLevel = Int(data[caretakerIndex].size / 10)
            data[caretakerIndex].title = "🧑‍⚕️ Caretaker Lvl \(newLevel)"
        }
    }
    
    func reverseAnimation() {
        for index in data.indices {
            data[index].offset = scatteredOffset(for: index)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                calculateOffsets()
            }
        }
    }

    
    func scatteredOffset(for index: Int) -> CGSize {
        let maxOffset: CGFloat = 300
        let x = CGFloat.random(in: -maxOffset...maxOffset)
        let y = CGFloat.random(in: -maxOffset...maxOffset)
        return CGSize(width: 2 * x, height: 0.25 * y)
    }
}



struct HomeView1_Previews: PreviewProvider {
    static var previews: some View {
        HomeView1()
            .environmentObject(AuthViewModel())
    }
}
