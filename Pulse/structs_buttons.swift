//  structs_buttons.swift

import SwiftUI

struct SortButton: View {
    var body: some View {
        Button(action: {
            print("Sort button tapped")
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 10).stroke(Color(UIColor.systemGray), lineWidth: 2)
                    .frame(width: 160, height: 40)
                    .padding(.leading, 215)
                    .layoutPriority(1)
                HStack {
                    Text("Sort by newest")
                        .padding(.leading, 215)
                    Image(systemName: "arrow.up.arrow.down")
                        
                    
                    
                }
            }
        }
                .accentColor(Color(UIColor.systemGray))
    }
}
struct AIButton: View {
    var body: some View {
        Button(action: {
            print("AI generator tapped")
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 50).stroke(Color(UIColor.darkGray), lineWidth: 2)
                    .frame(width: 160, height: 40)
                    .padding(.leading, 215)
                    .layoutPriority(1)
                HStack {
                    Image(systemName: "bolt.heart")
                        .padding(.leading, 215)
                        .foregroundColor(Color.black)
                    Text("Pulse Assistant")
                        .foregroundColor(Color(UIColor.darkGray))
                }
            }
            
        }
    }
}

struct structs_buttons_Previews: PreviewProvider {
    static var previews: some View {
            SortButton()
    }
}
