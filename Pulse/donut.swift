//
//  donut.swift
//  Pulse
//
//  Created by Yinglin Jiang on 4/7/24.
//


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

    // Define a set of colors to use in the chart and legend
    private let colors: [Color] = [.yellow, .orange, .green, .purple, .blue]

    var body: some View {
        VStack {
            Chart {
                ForEach(typeCount) { personality in
                    SectorMark(
                        angle: .value("count", Double(personality.count)),
                        innerRadius: .ratio(0.85),
                        angularInset: 2
                    )
                    .foregroundStyle(by: .value("type", personality.type))
                }
            }
            .scaleEffect(1.2)
            .frame(height: 300)
            .chartForegroundStyleScale([
                "The Outgoing Spirit": colors[0],
                "The Open-Minded Explorer": colors[1],
                "The Private Resident": colors[2],
                "The Engaged Citizen": colors[3],
                "The Easygoing Neighbor": colors[4]
            ])
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            
            // Legend
            ForEach(Array(zip(typeCount, colors)), id: \.0.id) { (personality, color) in
                HStack {
                    Rectangle()
                        .fill(color)
                        .frame(width: 20, height: 20)
                    Text(personality.type)
                }
            }
        }
        .onAppear {
            fetchPersonalityData()
        }
    }

    private func fetchPersonalityData() {
        let fs = Firestore.firestore()
        fs.collection("testing").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var personalityCounts: [String: Int] = [
                    "The Outgoing Spirit": 0,
                    "The Open-Minded Explorer": 0,
                    "The Private Resident": 0,
                    "The Engaged Citizen": 0,
                    "The Easygoing Neighbor": 0
                ]
                
                for document in querySnapshot!.documents {
                    if let personalityType = document.data()["personalityType"] as? String {
                        personalityCounts[personalityType, default: 0] += 1
                    }
                }
                
                // Calculate total count
                let totalCount = personalityCounts.values.reduce(0, +)
                
                // Update typeCount with percentages and ensure the order matches the colors
                if totalCount > 0 {
                    typeCount = [
                        Personality(type: "The Outgoing Spirit", count: personalityCounts["The Outgoing Spirit", default: 0]),
                        Personality(type: "The Open-Minded Explorer", count: personalityCounts["The Open-Minded Explorer", default: 0]),
                        Personality(type: "The Private Resident", count: personalityCounts["The Private Resident", default: 0]),
                        Personality(type: "The Engaged Citizen", count: personalityCounts["The Engaged Citizen", default: 0]),
                        Personality(type: "The Easygoing Neighbor", count: personalityCounts["The Easygoing Neighbor", default: 0])
                    ]
                }
            }
        }
    }
}




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
//    // Define a set of colors to use in the chart and legend
//    private let colors: [Color] = [.yellow, .orange, .green, .purple, .blue]
//
//    var body: some View {
//        VStack {
//            Chart(typeCount) { personality in
//                SectorMark(
//                    angle: .value(personality.type, Double(personality.count)),
//                    innerRadius: .ratio(0.85),
//                    angularInset: 2
//                )
//                .foregroundStyle(by: .value(personality.type, Double(personality.count)))
//            }
//            .scaleEffect(1.2)
//            .frame(height: 300)
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
//                // Calculate total count
//                let totalCount = personalityCounts.values.reduce(0, +)
//                
//                // Update typeCount with percentages
//                if totalCount > 0 {
//                    typeCount = personalityCounts.map { Personality(type: $0.key, count: ($0.value * 100) / totalCount) }
//                }
//            }
//        }
//    }
//}


#Preview {
    DonutChartView()
}
