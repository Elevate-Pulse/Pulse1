//  ProfileStructs.swift
/*structs included:
-TextField_Lined: textfield that's a line instead of rectangle
 -SecureField_Lined: securefield that's a line instead of rectangle
 */

import SwiftUI

struct TextField_Lined: View {
    let defaultString: String
    @Binding var text: String

    var body: some View {
        TextField(defaultString, text: $text)
            .padding(.horizontal)
            .padding(.vertical, 10)
            .frame(height: 50) // Adjust the height as needed
            .font(.custom("Poppins-Medium", size: 21))
            .background(
                VStack {
                    Spacer()
                    Rectangle()
                        .frame(height: 3)
                        .foregroundColor(Color(UIColor.darkGray))
                }
            )
            .frame(width: 180)
    }
}

struct SecureField_Lined: View {
    let defaultString: String
    @Binding var text: String

    var body: some View {
        SecureField(defaultString, text: $text)
            .padding(.horizontal)
            .padding(.vertical, 10)
            .frame(height: 50) // Adjust the height as needed
            .font(.custom("Poppins-Medium", size: 16))
            .background(
                VStack {
                    Spacer()
                    Rectangle()
                        .frame(height: 3)
                        .foregroundColor(Color(UIColor.darkGray))
                }
            )
            .frame(width: 180)
    }
}


struct EditProfileStructs_Previews: PreviewProvider {
    @State static var text = ""
    static var previews: some View {
        VStack {
            TextField_Lined(defaultString: "Insert string", text: $text)
            Divider()
            SecureField_Lined(defaultString: "Insert pw", text: $text)
        }
    }
}
