//  PulseHelperView.swift

import SwiftUI

struct PulseHelperQuestionnaireView: View {
    @State private var whatHappened: String = ""
    @State private var whenHappened: String = ""
    @State private var whereHappened: String = ""
    @State private var consequence: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Hi, I'm your Pulse Helper")
                .font(.custom("Poppins-Light", size: 24))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            VStack(spacing: -10) {
                Text("Please answer the questions below and I can create a post for you")
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom("Poppins-Light", size: 15))
                    .padding()
                .foregroundColor(Color.black)
                Text("You may type in phrases or in another language")
                    .fixedSize(horizontal: false, vertical: true)
                    //.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 10)
                    .foregroundColor(Color(UIColor.systemGray))
                    .font(.custom("Poppins-Light", size: 15))
            }
            .padding(.vertical, 10)
            VStack(spacing: 1) {
                QuestionTextfield(height: 75, question: "What happened?", text: $whatHappened) //find in CreatePostStructs
                QuestionTextfield(height: 75, question: "When did this happen?", text: $whenHappened) //find in CreatePostStructs
                QuestionTextfield(height: 75, question: "Where did this happen?", text: $whereHappened) //find in structs_textFields
                QuestionTextfield(height: 75, question: "How did this affect you?", text: $consequence) //find in CreatePostStructs
                StylePickerButton()
            }
        }

                Spacer()
        GenerateButton(response: "ai response 3")
        }
    }


#Preview {
    PulseHelperQuestionnaireView()
}
