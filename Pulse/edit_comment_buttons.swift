//
//  edit_comment_buttons.swift
//  Pulse
//
//  Created by Yinglin Jiang on 3/20/24.
//

import SwiftUI

struct editButton: View{
    @State private var makeEdits = false
    var body: some View{
        Button(action: {
            print("edit button tapped")
            
            makeEdits = true
        }) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(UIColor.darkGray))
                .frame(width: 80, height: 40)
                .overlay(
                    Text("Edit")
                        .foregroundColor(Color.white)
                        .font(.custom("Poppins-Light", size: 16))
                )
        }
        .sheet(isPresented: $makeEdits) {
            EditProfileView()
        }
    }
}

#Preview {
    editButton()
}
