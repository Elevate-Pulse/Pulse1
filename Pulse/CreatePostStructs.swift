//  CreatePostStructs.swift
/*structs included:
-TypeInSubject: textfield w/ words "type in subject"
 -QuestionTextField: textfield w/ question above it
 */

import SwiftUI

struct TypeInSubject: View {
    @Binding var subjectText: String
    var body: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(UIColor.darkGray), lineWidth: 2)
                .frame(width: UIScreen.main.bounds.width - 20, height: 40)
            
            TextField("Type in subject", text: $subjectText)
                .padding(.horizontal, 10)
                .font(.custom("Poppins-Medium", size: 16))
        }
        .foregroundColor(Color(UIColor.darkGray))
        .padding([.horizontal, .vertical], 10)
    }
}

struct QuestionTextfield: View {
    let height: CGFloat
    let question: String
    @Binding var text: String
    
    var body: some View {
        VStack(spacing: 0) {
            Text(question)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.vertical, -2)
                .foregroundColor(Color(UIColor.darkGray))
                .font(.custom("Poppins-Light", size: 16))
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(UIColor.darkGray), lineWidth: 2)
                    .frame(width: UIScreen.main.bounds.width - 20, height: height)
                    .foregroundColor(Color(UIColor.darkGray))
                TextField("", text: $text)
                    .padding([.horizontal, .vertical], 10)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color(UIColor.darkGray))
                    .font(.custom("Poppins-Light", size: 16))
            }
            .padding([.horizontal, .vertical], 10)
        }
    }
}

struct CreatePostStructs_Previews: PreviewProvider {
    @State static var text = ""
    static var previews: some View {
        VStack {
           TypeInSubject(subjectText: $text)
            Divider()
            QuestionTextfield(height: 100, question: "What is the question?", text: $text)
            Divider()
        }
    }
}
