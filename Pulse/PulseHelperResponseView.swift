//
//  PulseHelperResponseView.swift
//  Pulse
//
//  Created by student on 3/10/24.
//

import SwiftUI

struct PulseHelperResponseView: View {
    @State var bodyText: String
    var body: some View {
        VStack(spacing: 0) {
            Text("Ripple")
                .font(.custom("Poppins-Light", size: 24))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            VStack(spacing: -25) {
                Text("Result")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom("Poppins-Light", size: 21))
                    .padding()
                    .foregroundColor(Color.black)
                Text(bodyText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .foregroundColor(Color(UIColor.darkGray))
                    .font(.custom("Poppins-Light", size: 18))
            }
            Spacer()
            ImportFileButton()
            
        }
        RegenOrGoodButtons()
    }
}

#Preview {
    PulseHelperResponseView(bodyText: "ai's response")
}
