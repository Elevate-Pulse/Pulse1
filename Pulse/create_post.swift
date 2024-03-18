//
//  create_post.swift
//  Pulse
//
//  Created by Yinglin Jiang on 3/7/24.
//

import SwiftUI

struct create_post : View {
    @State private var selectedTag: String?
    @State private var issueDetails: String = ""
    @State private var dailyLifeImpact: String = ""
    @State private var desiredChange: String = ""
    let tags = ["Crime", "Homelessness", "Vandalism", "Event", "Pothole", "Shooting", "Safety", "Noise pollution", "Public transportation", "Traffic", "Community health", "School & Education", "Public spaces", "Infrastructure"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                Text("Create a post")
                    .font(.title)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1) // Border color and width
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white)) // Background color
                        .frame(height: 40) // Adjust the height as needed
                    
                    Text("Enter a subject")
                        .foregroundColor(Color(UIColor.darkGray))
                        .padding(.leading, 10)
                }
                .padding(.leading)
                
                Text("Tags")
                    .font(.title)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(tags, id: \.self) { tag in
                            Text(tag)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(selectedTag == tag ? Color.black : Color.gray.opacity(0.2))
                                .foregroundColor(selectedTag == tag ? Color.white : Color.black)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .onTapGesture {
                                    selectedTag = tag
                                }
                        }
                    }
                    .padding(.leading)
                }
                .frame(height: 40)
                
//                PromptTextView(prompt: "Please describe in details the issue you want to resolve", text: $issueDetails)
//                PromptTextView(prompt: "How does this affect your daily life?", text: $dailyLifeImpact)
//                PromptTextView(prompt: "What change do you want to see?", text: $desiredChange)
                
                TextEditor(text: $issueDetails)
                    .frame(maxWidth: .infinity, minHeight: 250, maxHeight: .infinity)
                    .padding(4)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    .padding([.leading, .bottom, .trailing])
                    .onTapGesture {
                        withAnimation {
                            if issueDetails.isEmpty {
                                // Clear placeholder text when the user taps the TextEditor
                                issueDetails = ""
                            }
                        }
                    }
                    .overlay(
                        VStack {
                            if issueDetails.isEmpty {
                                Text("Please describe in details the issue you want to resolve")
                                    .foregroundColor(.gray)
                                    .padding(.leading, 8)
    //                            Spacer()
                                
//                                Text("How does this")
                                
                            }
                        },
                        alignment: .topLeading
                    )
                
//                AIButton()
            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
        }
    }
}

//struct PromptTextView: View {
//    let prompt: String
//    @Binding var text: String
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            if text.isEmpty {
//                Text(prompt)
//                    .foregroundColor(.gray)
//                    .padding([.leading, .top])
//            }
//            
//            TextEditor(text: $text)
//                .frame(minHeight: text.isEmpty ? 20 : 50, maxHeight: .infinity)
//                .padding(4)
//                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
//                .padding([.leading, .bottom, .trailing])
//        }
//    }
//}


#Preview {
    create_post()
}
