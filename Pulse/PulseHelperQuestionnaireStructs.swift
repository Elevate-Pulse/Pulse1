//  PulseHelperQuestionnaireStructs.swift
/*structs included:
-StylePickerButton: button to pick style of ai generated text
 -GenerateButton: button for ai to generate response
 */

import SwiftUI

struct StylePickerButton: View {
    var body: some View {
        Button(action: {
            print("Style picker Button tapped")
        }) {
            ZStack() {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(UIColor.darkGray), lineWidth: 2)
                    .frame(width: UIScreen.main.bounds.width - 48, height: 40)
                    .overlay(
                        HStack {
                            Text("Select style")
                                .padding(.horizontal, 10)
                            Spacer()
                            HStack {
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 15))
                                    .foregroundColor(Color(UIColor.darkGray))
                                    .padding(.trailing, 10)
                            }
                        }
                    )
            }
            .foregroundColor(Color(UIColor.darkGray))
            .padding([.horizontal, .vertical], 10)
        }
    }
}

struct GenerateButton: View {
    @State private var showPHRV = false
    let response: String
    var body: some View {
        Button(action: {
            print("Generate button tapped")
            showPHRV = true
        }) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: 35/255, green: 109/255, blue: 97/255))
                .frame(width: UIScreen.main.bounds.width - 48, height: 50)
                .overlay(
                    Text("Generate")
                        .foregroundColor(Color.white)
                        .font(.custom("Poppins-Light", size: 16))
                )
        }
        .sheet(isPresented: $showPHRV) {
            PulseHelperResponseView(bodyText: "ai response")
        }
    }
}

struct PulseHelperQuestionnaireStructs_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StylePickerButton()
            Divider()
            GenerateButton(response: "ai response")
            Divider()
        }
    }
}
