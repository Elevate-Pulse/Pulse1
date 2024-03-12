//
//  PulseHelperView.swift
//  Pulse
//
//  Created by student on 3/10/24.
//

import SwiftUI

struct PulseHelperQuestionnaireView: View {
    @State private var whatHappened: String = ""
    @State private var whenHappened: String = ""
    @State private var whereHappened: String = ""
    @State private var consequence: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: -20) {
                Button(action: {
                    print("Going back")
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color(UIColor.systemGray))
                }
                .padding()
                Text("Hi, I'm your Pulse Helper")
                    .font(.custom("Poppins-Medium", size: 24))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            
            VStack(spacing: -25) {
                Text("Please answer the questions below and I can create a post for you")
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                .foregroundColor(Color.black)
                Text("You may type in phrases or in another language")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .foregroundColor(Color(UIColor.systemGray))
                    .font(.custom("Poppins-Medium", size: 155))
            }
            VStack(spacing: 1) {
                QuestionTextfield(height: 75, question: "What happened?", text: $whatHappened) //find in structs_textFields
                QuestionTextfield(height: 75, question: "When did this happen?", text: $whenHappened) //find in structs_textFields
                QuestionTextfield(height: 75, question: "Where did this happen?", text: $whereHappened) //find in structs_textFields
                QuestionTextfield(height: 75, question: "How did this affect you?", text: $consequence) //find in structs_textFields
                StylePickerButton() //find in structs_buttons
            }
        }

                Spacer()
                GenerateButton()
        }
    }


#Preview {
    PulseHelperQuestionnaireView()
}
