//
//  PulseHelperResponseView.swift
//  Pulse
//
//  Created by student on 3/10/24.
//

import SwiftUI

struct PulseHelperResponseView: View {
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
                Text("Pulse Helper")
                    .font(.system(size: 25))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            
            VStack(spacing: -25) {
                Text("Result")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 21))
                    .padding()
                    .foregroundColor(Color.black)
                Text("hi")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .foregroundColor(Color(UIColor.darkGray))
                    .font(.system(size: CGFloat(18)))
            }
            Spacer()
            ImportFileButton()
            
        }
        RegenOrGoodButtons()
    }
}

#Preview {
    PulseHelperResponseView()
}
