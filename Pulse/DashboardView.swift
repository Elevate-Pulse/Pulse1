//
//  dashboard.swift
//  Pulse
//
//  Created by Yinglin Jiang on 3/11/24.
//

import SwiftUI
import Charts

//struct dashboard: View {
//    var data = [
//        sampleData(
//            week: "Last week",
//            count: 5
//        ),
//
//        sampleData(
//            week: "This week",
//            count: 10
//        )
//    ]
//    var body: some View {
//        Chart{
//            ForEach (data) { d in
//                BarMark(x: .value("Response", d.week),
//                        y: .value("Count", d.count))
//                .annotation{
//                    Text(String(d.count))
//                }
////                SectorMark(angle: .value("Week", d.count))
////                    .foregroundStyle(by: .value("Response", d.week))
//            }
//        }
//        .padding()
//    }
//}

import SwiftUI

struct Bar: View {
    var value: CGFloat
    var label: String

    var body: some View {
        VStack {
            Rectangle()
                .fill(label == "last week" ? Color.gray : Color.black)
                .frame(width: 30, height: value)
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
    // Dummy data for the bar values
    let data = [
        (lastWeek: 50, thisWeek: 70),
        (lastWeek: 80, thisWeek: 40),
        (lastWeek: 30, thisWeek: 90),
        (lastWeek: 60, thisWeek: 60)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                ForEach(data.indices, id: \.self) { index in
                    CardView(lastWeekValue: CGFloat(data[index].lastWeek),
                             thisWeekValue: CGFloat(data[index].thisWeek))
                }
            }
            .padding()
        }
    }
}



#Preview {
    dashboard()
}
