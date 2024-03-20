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
    @State var selectedAnswer = 1 // Default answer to start wit
    @State var showPopup: Bool = false
    // Dummy data for the bar values
    let data = [
        (lastWeek: 50, thisWeek: 70),
        (lastWeek: 80, thisWeek: 40),
        (lastWeek: 30, thisWeek: 90),
        (lastWeek: 60, thisWeek: 60)
    ]
    
    var body: some View {
        
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
            
            NavigationView{
                Button("Show popup"){
                    withAnimation{
                        showPopup.toggle()
                    }
                }
            }
            .popupNavigationView(horizontalPadding: 50, show: $showPopup){
                //content here
                SurveyQuestionView(selectedAnswer: $selectedAnswer, question: "Rate 1-5 how safe do you feel in the past 7 days in your community?", range: 1...5)
            }
        }
    }
}
#Preview {
    dashboard()
}

