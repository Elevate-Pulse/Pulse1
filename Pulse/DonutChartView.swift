//
//  DonutChartView.swift
//  Pulse
//
//  Created by Yinglin Jiang on 3/19/24.
//

//import SwiftUI
//import Charts
//
//struct Personality: Identifiable {
//    let id = UUID()
//    let type: String
//    let count: Int
//}
//
//struct DonutChartView: View {
//    @State private var typeCount: [Personality] = [
//        .init(type: "The Outgoing Spirit", count: 10),
//        .init(type: "The Open-Minded Explorer", count: 30),
//        .init(type: "The Private Resident", count: 5),
//        .init(type: "The Engaged Citizen", count: 15),
//        .init(type: "The Easygoing Neighbor", count: 10)
//    ]
//    
//    var body: some View{
//        Chart(typeCount) { personality in
//            SectorMark (
//                angle: .value(
//                    Text(verbatim: personality.type),
//                    personality.count
//                ),
//                innerRadius: .ratio(0.85),
//                angularInset: 8
//            )
//            .foregroundStyle(
//                by: .value(
//                    Text(verbatim: personality.type),
//                    personality.count
//                )
//            )
//        }
//    }
//        
//}

import SwiftUI
import Charts

struct Personality: Identifiable {
    let id = UUID()
    let type: String
    let count: Int
}

struct DonutChartView: View {
    @State private var typeCount: [Personality] = [
        .init(type: "The Outgoing Spirit", count: 10),
        .init(type: "The Open-Minded Explorer", count: 30),
        .init(type: "The Private Resident", count: 5),
        .init(type: "The Engaged Citizen", count: 15),
        .init(type: "The Easygoing Neighbor", count: 10)
    ]
    
    // Define a set of colors to use in the chart and legend
    private let colors: [Color] = [.red, .blue, .green, .orange, .purple]
    
    var body: some View {
        VStack {
            // Chart
            Chart(typeCount) { personality in
                SectorMark(
                    angle: .value(personality.type, personality.count),
                    innerRadius: .ratio(0.85), // Adjusted for a larger "donut" appearance
                    angularInset: 2 // Adjusted for closer sectors
                )
                .foregroundStyle(by: .value(personality.type, personality.count))
            }
            .scaleEffect(1.2) // Make the chart larger; adjust scale as needed
            .frame(height: 300) // Adjust frame size as needed
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
    }
}

//struct DonutChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        DonutChartView()
//    }
//}


#Preview{
    DonutChartView()
}

