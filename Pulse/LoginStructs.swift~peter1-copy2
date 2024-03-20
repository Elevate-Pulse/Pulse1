//  LoginStructs.swift
/*structs included:
-TextField_Base: basic textfield used to input email for example
 -SecureField_Base: basic securefield used to input passwords
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
    let typeOfText: String
    @Binding var text: String
    
    var body: some View {
        SecureField(typeOfText, text: $text)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke((Color(UIColor.darkGray))))
            .frame(width: 300, height: 50)
            .font(.custom("Poppins-Medium", size: 16))
    }
}

struct LoginStructs_Previews: PreviewProvider {
    @State static var text = ""
    static var previews: some View {
        VStack {
            TextField_Base(typeOfText: "Email", text: $text)
        Divider()
            SecureField_Base(typeOfText: "Password", text: $text)
        Divider()
        }
    }
}
