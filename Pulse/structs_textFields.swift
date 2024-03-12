//  structs_textFields.swift
/*
 structs included:
 -TextField_Base: textfield used for inputting email
 -SecureField_Base: securefield used for inputting password
 -TypeInSubject: textfield used to type in subject when creating a post
 -PulseHelperQuestion: textfield used to ask user to help ai generate help them generate post
 */

import SwiftUI

struct TextField_Base: View {
    let typeOfText: String
    @Binding var text: String
    
    var body: some View {
        TextField(typeOfText, text: $text)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke((Color(UIColor.darkGray))))
            .frame(width: 300, height: 50)
            .font(.custom("Poppins-Medium", size: 16))
    }
}

struct SecureField_Base: View {
    @Binding var text: String
    
    var body: some View {
        SecureField("Password", text: $text)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke((Color(UIColor.darkGray))))
            .frame(width: 300, height: 50)
            .font(.custom("Poppins-Medium", size: 16))
    }
}

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
                .font(.custom("Poppins-Medium", size: 16))
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(UIColor.darkGray), lineWidth: 2)
                    .frame(width: UIScreen.main.bounds.width - 20, height: height)
                    .foregroundColor(Color(UIColor.darkGray))
                TextField("", text: $text)
                    .padding([.horizontal, .vertical], 10)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color(UIColor.darkGray))
                    .font(.custom("Poppins-Medium", size: 16))
            }
            .padding([.horizontal, .vertical], 10)
        }
    }
}


struct structs_textFields_Previews: PreviewProvider {
    @State static var text = ""
    static var previews: some View {
        VStack {
            TextField_Base(typeOfText: "Email", text: $text)
        Divider()
            SecureField_Base(text: $text)
        Divider()
        TypeInSubject(subjectText: $text)
            Divider()
            QuestionTextfield(height: 75, question: "What happened?", text: $text)
        }
    }
}














