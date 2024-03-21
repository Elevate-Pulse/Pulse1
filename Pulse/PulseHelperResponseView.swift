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
        VStack(spacing: 25) {
            Text("Ripple")
                .font(.custom("Poppins-Light", size: 24))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
            
            VStack(spacing: 10) {
                Text("Result")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom("Poppins-Light", size: 21))
                    .padding(.horizontal, 24)
                    .foregroundColor(Color.black)
                Text(bodyText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
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
