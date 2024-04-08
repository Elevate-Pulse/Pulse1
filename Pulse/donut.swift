//
//  donut.swift
//  Pulse
//
//  Created by Yinglin Jiang on 4/7/24.
//


//import SwiftUI
//import Charts
//import FirebaseFirestore
//
//struct Personality: Identifiable {
//    let id = UUID()
//    let type: String
//    var count: Int
//}
//
//struct DonutChartView: View {
//    @State private var typeCount: [Personality] = []
//
//        // Define a set of colors to use in the chart and legend
//        private let colors: [Color] = [.yellow, .orange, .green, .purple, .blue]
//
//        var body: some View {
//            VStack {
//                Chart {
//                    ForEach(typeCount) { personality in
//                        SectorMark(
//                            angle: .value("count", Double(personality.count))
//                        )
//                        .foregroundStyle(by: .value("type", personality.type))
//                    }
//                }
//                .frame(height: 300) // Make sure there's enough space for the chart
//                .chartForegroundStyleScale([
//                    "The Outgoing Spirit": colors[0],
//                    "The Open-Minded Explorer": colors[1],
//                    "The Private Resident": colors[2],
//                    "The Engaged Citizen": colors[3],
//                    "The Easygoing Neighbor": colors[4]
//                ])
//            }
//        .onAppear {
//            fetchPersonalityData()
//        }
//    }
//
//    private func fetchPersonalityData() {
//        let fs = Firestore.firestore()
//        fs.collection("testing").getDocuments { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                var personalityCounts: [String: Int] = [
//                    "The Outgoing Spirit": 0,
//                    "The Open-Minded Explorer": 0,
//                    "The Private Resident": 0,
//                    "The Engaged Citizen": 0,
//                    "The Easygoing Neighbor": 0
//                ]
//                
//                for document in querySnapshot!.documents {
//                    if let personalityType = document.data()["personalityType"] as? String {
//                        personalityCounts[personalityType, default: 0] += 1
//                    }
//                }
//                
//                let totalCount = personalityCounts.values.reduce(0, +)
//                
//                if totalCount > 0 {
//                    // Update the state on the main thread
//                    DispatchQueue.main.async {
//                        self.typeCount = personalityCounts.map { Personality(type: $0.key, count: ($0.value * 100) / totalCount) }
//                    }
//                }
//            }
//        }
//    }
//}




//import SwiftUI
//import Charts
//struct Personality: Identifiable {
//    let id = UUID()
//    let type: String
//    let count: Int
//    
//}
//struct DonutChartView: View {
//    @State private var typeCount: [Personality] = [
//        .init(type: "The Outgoing Spirit", count: 10),
//        .init(type: "The Open-Minded Explorer", count: 30),
//        .init(type: "The Private Resident", count: 5),
//        .init(type: "The Engaged Citizen", count: 15),
//        .init(type: "The Easygoing Neighbor", count: 10)
//    ]
//    
//    // Define a set of colors to use in the chart and legend
//    private let colors: [Color] = [Color("yellow"), Color("peach"), Color("light_green"), Color("purple"), Color("blue")]
//    
//    var body: some View {
//        VStack {
//            // Chart
//            Chart(typeCount) { personality in
//                SectorMark(
//                    angle: .value(personality.type, personality.count),
//                    innerRadius: .ratio(0.85), // Adjusted for a larger "donut" appearance
//                    angularInset: 2 // Adjusted for closer sectors
//                )
//                .foregroundStyle(by: .value(personality.type, personality.count))
//            }
//            .scaleEffect(1.2) // Make the chart larger; adjust scale as needed
//            .frame(height: 300) // Adjust frame size as needed
//            .chartXAxis(.hidden)
//            .chartYAxis(.hidden)
//            
//            // Legend
//            ForEach(Array(zip(typeCount, colors)), id: \.0.id) { (personality, color) in
//                HStack {
//                    Rectangle()
//                        .fill(color)
//                        .frame(width: 20, height: 20)
//                    Text(personality.type)
//                }
//            }
//        }
//    }
//}








//correct output:

import SwiftUI
import Charts
import FirebaseFirestore

struct Personality: Identifiable {
    let id = UUID()
    let type: String
    var count: Int
}

struct DonutChartView: View {
    @State private var typeCount: [Personality] = []
    @State private var totalCount: Int = 0

    // Define a set of colors to use in the chart and legend
//    private let colors: [Color] = [Color("yellow_c"), Color("peach"), Color("light_green"), Color("purple_c"), Color("blue_c")]

    var body: some View {
        ZStack {
            VStack {
                Chart(typeCount) { personality in
                    SectorMark(
                        angle: .value(personality.type, Double(personality.count)),
                        innerRadius: .ratio(0.85),
                        angularInset: 2
                    )
                    .foregroundStyle(self.colorForType(personality.type))
                }
                .scaleEffect(1.2)
                .frame(height: 300)
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
                .padding(.bottom, 55)
                
                // Legend
                ForEach(typeCount, id: \.id) { personality in
                    HStack {
                        Rectangle()
                            .fill(self.colorForType(personality.type))
                            .frame(width: 20, height: 20)
                        Text(personality.type)
                            .font(Font.custom("Comfortaa-Light", size: 14))
                    }
                }
            }
            
            // Overlay text in the center of the donut chart
            if totalCount > 0 {
                Text("\(totalCount) people answered")
                    .font(Font.custom("Comfortaa-Light", size: 20)) // Adjust font size as needed
                    .foregroundColor(.black) // Change text color as needed
                    .offset(y: -100)
            }
        }
        .onAppear {
            fetchPersonalityData()
        }
    }

    private func fetchPersonalityData() {
        let fs = Firestore.firestore()
        fs.collection("survey_responses").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var personalityCounts: [String: Int] = [
                    "Outgoing": 0,
                    "Open-Minded": 0,
                    "Private": 0,
                    "Engaged": 0,
                    "Easygoing": 0
                ]
                
                for document in querySnapshot!.documents {
                    if let personalityType = document.data()["personalityType"] as? String {
                        personalityCounts[personalityType, default: 0] += 1
                    }
                }
                
                // Calculate total count
                self.totalCount = personalityCounts.values.reduce(0, +)
                
                // Update typeCount with percentages
                if totalCount > 0 {
                    typeCount = personalityCounts.map { Personality(type: $0.key, count: ($0.value * 100) / totalCount) }
                }
            }
        }
    }
    
    private func colorForType(_ type: String) -> Color {
        switch type {
        case "Outgoing":
            return Color("yellow_c")
        case "Open-Minded":
            return Color("peach") // Ensure this color is defined in your asset catalog or use a SwiftUI color approximation
        case "Private":
            return Color("light_green") // Define this color too
        case "Engaged":
            return Color("purple_c")
        case "Easygoing":
            return Color("blue_c")
        default:
            return Color.gray // Fallback color
        }
    }
}


#Preview {
    DonutChartView()
}



// Legend
//            ForEach(Array(zip(typeCount, colors)), id: \.0.id) { (personality, color) in
//                HStack {
//                    Rectangle()
//                        .fill(color)
//                        .frame(width: 20, height: 20)
//                    Text(personality.type)
//                }
//            }
