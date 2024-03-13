//  ProfileStructs.swift
/*structs included:
-EditButton: button edit name and neighborhood
 */

import SwiftUI

struct EditButton: View {
    var body: some View {
        Button(action: {
            print("Edit button tapped")
        }) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(UIColor.darkGray))
                .frame(width: UIScreen.main.bounds.width - 300, height: 50)
                .overlay(
                    Text("Edit")
                        .foregroundColor(Color.white)
                        .font(.custom("Poppins-Light", size: 16))
                )
        }
    }
}


struct ProfileStructs_Previews: PreviewProvider {
    @State static var text = ""
    static var previews: some View {
        VStack {
            EditButton()
            Divider()
        }
    }
}
