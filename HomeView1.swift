//
//  HomeView1.swift
//  Pulse
//
//  Created by Peter Guan on 4/5/24.
//
//.foregroundColor(Color(red: 28/255, green: 21/255, blue: 21/255)) <-- black
//.foregroundColor(Color(red: 35/255, green: 109/255, blue: 97/255)) <-- pulse green
//.foregroundColor(Color(red: 1.0, green: 0.996, blue: 0.953)) <-- cream
//.foregroundColor(Color(red: 88/255, green: 111/255, blue: 124/255)) <-- gray


/*
 -Why tf does login screen have back buttons
 */


import SwiftUI

struct DataItem: Identifiable {
    var id = UUID()
    var title: String
    var size: CGFloat
    var color: Color
    var offset = CGSize.zero
}

struct HomeView1: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var isExpanded = true // Goals section is expanded by default
    
    var body: some View {
        let userName = viewModel.currentUser?.name ?? "Guest"
        VStack(spacing: 0) {
            TopBarView()
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("\(userName), you are a")
                                .font(.custom("Comfortaa-Regular", size: 18))
                                .foregroundColor(Color(red: 28/255, green: 21/255, blue: 21/255))
                            Text("Private Resident")
                                .font(.custom("Comfortaa-Bold", size: 21))
                                .foregroundColor(Color(red: 35/255, green: 109/255, blue: 97/255))
                        }
                        .padding(.top, 45)
                        Spacer()
                        Button(action: {
                            print("retake quiz tapped on")
                        }) {
                            Text("Retake Quiz")
                                .foregroundColor(Color(red: 35/255, green: 109/255, blue: 97/255))
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .font(.custom("Comfortaa-Regular", size: 18))
                                .background(
                                    RoundedRectangle(cornerRadius: 25)
                                        .foregroundColor(Color(red: 1.0, green: 0.996, blue: 0.953))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 25)
                                                .stroke(Color(red: 35/255, green: 109/255, blue: 97/255), lineWidth: 2)
                                        )
                                )
                        }
                        .padding(.top, 45)
                    }
                    Text("Just like 50% of your neighbors")
                        .font(.custom("Comfortaa-Regular", size: 18))
                        .foregroundColor(Color(red: 28/255, green: 21/255, blue: 21/255))
                    Text("Private Residents do this and that.")
                        .font(.custom("Comfortaa-Regular", size: 18))
                        .foregroundColor(Color(red: 28/255, green: 21/255, blue: 21/255))
                        .padding(.bottom, 10)
                    // Strengths and Weaknesses section
                    StrengthsWeaknessesSection()
                    
                    // Weekly Goals section
                    Text("Weekly Goals")
                        .font(.custom("Comfortaa-Bold", size: 21))
                        .foregroundColor(Color(red: 28/255, green: 21/255, blue: 21/255))
                        .padding(.top, 10) // Add some top padding
                    GoalsView()
                    
                    Text("Your dominant ??? is:")
                        .font(.custom("Comfortaa-Regular", size: 21))
                        .foregroundColor(Color(red: 28/255, green: 21/255, blue: 21/255))
                    Text("idk")
                        .font(.custom("Comfortaa-Bold", size: 24))
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
        }.navigationBarBackButtonHidden(true)
    }
}

struct TopBarView: View {
    var body: some View {
        Text("1")
            .padding(.horizontal, UIScreen.main.bounds.width)
            .padding(.bottom, -10)
            .background(Color(red: 1.0, green: 0.996, blue: 0.953))
    }
}


struct StrengthsWeaknessesSection: View {
    @State private var isExpanded = false
    
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
                HStack {
                    StrengthWeakness(label: "Strengths", bulletText1: "This is one of the strengths", bulletText2: "This is another strength", bulletText3: "This is the last strength")
                    StrengthWeakness(label: "Weaknesses", bulletText1: "This is one of the weaknesses", bulletText2: "This is another weakness", bulletText3: "This is the last weakness")
                }
                .padding(.vertical, 15)
            }
        }
    }
}

struct StrengthWeakness: View {
    var label: String
    var bulletText1: String
    var bulletText2: String
    var bulletText3: String
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color(red: 255/255, green: 194/255, blue: 168/255))
                .frame(width: 170, height: 30)
                .overlay(
                    Text(label)
                        .font(.custom("Comfortaa-Regular", size: 15))
                        .foregroundColor(Color(red: 28/255, green: 21/255, blue: 21/255))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke((Color(red: 88/255, green: 111/255, blue: 124/255)), lineWidth: 1)
                )

            Rectangle()
                .fill(Color(red: 1.0, green: 0.996, blue: 0.953))
                .frame(width: 170, height: 120)
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke((Color(red: 88/255, green: 111/255, blue: 124/255)), lineWidth: 1)
                )
                .overlay(
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Circle()
                                .fill(Color(red: 255/255, green: 194/255, blue: 168/255))
                                .frame(width: 10, height: 10)
                            Text(bulletText1)
                                .foregroundColor(Color(red: 28/255, green: 21/255, blue: 21/255))
                                .font(.custom("Comfortaa-Regular", size: 15))
                        }
                        HStack {
                            Circle()
                                .fill(Color(red: 255/255, green: 194/255, blue: 168/255))
                                .frame(width: 10, height: 10)
                            Text(bulletText2)
                                .foregroundColor(Color(red: 28/255, green: 21/255, blue: 21/255))
                                .font(.custom("Comfortaa-Regular", size: 15))
                        }
                        HStack {
                            Circle()
                                .fill(Color(red: 255/255, green: 194/255, blue: 168/255))
                                .frame(width: 10, height: 10)
                            Text(bulletText3)
                                .foregroundColor(Color(red: 28/255, green: 21/255, blue: 21/255))
                                .font(.custom("Comfortaa-Regular", size: 15))
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
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(goalText)
                .font(.custom("Comfortaa-Regular", size: 15))
                .foregroundColor(Color(red: 28/255, green: 21/255, blue: 21/255))
            ProgressBar(progress: progress)
        }
    }
}

struct ProgressBar: View {
    @State private var progress: Double
    @State private var showWaitMessage = false // Added state for showing wait message
    
    init(progress: Double) {
        self._progress = State(initialValue: progress)
    }
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        let progressBarWidth = screenWidth - 50
        
        return Button(action: {
            if self.progress < 1.0 {
                self.progress += 1.0 / 6.5 // Increment progress by 1 level
            } else {
                // Show the wait message if progress is already complete
                self.showWaitMessage = true
            }
            // Cap the progress to maximum 1.0 (7/7)
            if self.progress > 1.0 {
                self.progress = 1.0
            }
        }) {
            HStack(spacing: 30) {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: progressBarWidth - 50, height: 35)
                        .foregroundColor(Color(red: 0.9255, green: 0.9294, blue: 0.9451))
                    
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: CGFloat(self.progress) * (progressBarWidth - 50), height: 35)
                        .foregroundColor(Color(red: 161/255, green: 204/255, blue: 255/255))
                    
                    Text(String(format: "%.0f/7", self.progress * 7))
                        .foregroundColor(Color(red: 88/255, green: 111/255, blue: 124/255))
                        .font(.custom("Comfortaa-Regular", size: 15))
                        .padding(.horizontal, 8)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .offset(x: CGFloat(self.progress) * (progressBarWidth - 50) - 15, y: -18)
                }
                
                if progress >= 1.0 && progress <= 7.0 {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(Color(red: 161/255, green: 204/255, blue: 255/255))
                        .font(.system(size: 24))
                } else {
                    Image(systemName: "plus.app")
                        .foregroundColor(Color(red: 161/255, green: 204/255, blue: 255/255))
                        .font(.system(size: 27))
                }
            }
        }
        // Add message bubble when showWaitMessage is true
        .overlay(
            Group {
                if showWaitMessage {
                    MessageBubble(isProgressComplete: progress == 1.0)
                }
            }
        )
    }
}

struct MessageBubble: View {
    @State private var isShowing = true
    var isProgressComplete: Bool

    var body: some View {
        let backgroundColor: Color = isProgressComplete ? Color(red: 0.9255, green: 0.9294, blue: 0.9451) : Color(red: 0.9255, green: 0.9294, blue: 0.9451)

        return VStack {
            Text(isProgressComplete ? "Please until next week for new goals" : "Please until next week for new goals")
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
            Goal(progress: 1/7, goalText: "Pick up a piece of trash")
            Goal(progress: 6/7, goalText: "ooga booga")
            Goal(progress: 2/7, goalText: "yurr")
        }
    }
}

struct Circles: View {
    @State var data: [DataItem] = [
        
        DataItem(title: "🧑‍⚕️ Caretaker", size: 120, color: Color(red: 186/255, green: 255/255, blue: 201/255)),
               DataItem(title: "🙋‍♂️ Volunteer", size: 110, color: Color(red: 161/255, green: 204/255, blue: 255/255)),
               DataItem(title: "📢 Activist", size: 100, color: Color(red: 255/255, green: 194/255, blue: 168/255)),
               DataItem(title: "✌️ Peacemaker", size: 90, color: Color(red: 220/255, green: 185/255, blue: 255/255)),
               DataItem(title: "😊 Friend", size: 80, color: Color(red: 255/255, green: 244/255, blue: 189/255)),
                 
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
                                    .stroke(Color(red: 28/255, green: 21/255, blue: 21/255), lineWidth: 1)
                            )
                        Text(item.title.prefix(1))
                            .font(.custom("Comfortaa-Regular", size: item.size * 0.5))
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
            reverseAnimation()
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
