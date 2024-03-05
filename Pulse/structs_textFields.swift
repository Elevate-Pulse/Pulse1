//  structs_textFields.swift

import SwiftUI

struct TextField_Base: View {
    let typeOfText: String
    @Binding var text: String
    
    var body: some View {
        TextField(typeOfText, text: $text)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke((Color(UIColor.darkGray))))
            .frame(width: 300, height: 50)
    }
}

struct SecureField_Base: View {
    @Binding var text: String
    
    var body: some View {
        SecureField("Password", text: $text)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke((Color(UIColor.darkGray))))
            .frame(width: 300, height: 50)
    }
}

struct structs_textFields_Previews: PreviewProvider {
    @State static var text = ""
    static var previews: some View {
            TextField_Base(typeOfText: "Email", text: $text)
            //SecureField_Base(text: $text)
    }
}














