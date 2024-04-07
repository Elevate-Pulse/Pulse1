//
//  donutStruct.swift
//  Pulse
//
//  Created by Yinglin Jiang on 3/19/24.
//

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
    
    var body: some View{
        Chart(typeCount) { personality in
            SectorMark (
                angle: .value(
                    Text(verbatim: personality.type),
                    personality.count
                ),
                innerRadius: .ratio(0.85),
                angularInset: 8
            )
            .foregroundStyle(
                by: .value(
                    Text(verbatim: personality.type),
                    personality.count
                )
            )
        }
    }
        
}

#Preview{
    DonutChartView()
}

