//  PulseHelperResponseStructs.swift
/*structs included:
-ImportFileButton: adds media (links, media, poll)
 -RegenOrGoodButtons: regenerate and looks good buttons in response to ai
 */

import SwiftUI

struct ImportFileButton: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
            .frame(width: UIScreen.main.bounds.width - 48, height: 100)
            .overlay(
                VStack {
                    Text("Add media")
                        .foregroundColor(Color(UIColor.darkGray))
                        .font(.custom("Poppins-Light", size: 16))
                    HStack(spacing: 50) {
                        Button(action: {
                            print("link tapped")
                        }) {
                            VStack {
                                Image(systemName: "link")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color(UIColor.darkGray))
                                Text("Link")
                                    .foregroundColor(Color(UIColor.darkGray))
                                    .font(.custom("Poppins-Light", size: 16))
                            }
                        }
                        Button(action: {
                            print("media tapped")
                        }) {
                            VStack {
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color(UIColor.darkGray))
                                Text("Media")
                                    .foregroundColor(Color(UIColor.darkGray))
                                    .font(.custom("Poppins-Light", size: 16))
                            }
                        }
                        Button(action: {
                            print("poll tapped")
                        }) {
                            VStack {
                                Image(systemName: "chart.bar.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color(UIColor.darkGray))
                                Text("Poll")
                                    .foregroundColor(Color(UIColor.darkGray))
                                    .font(.custom("Poppins-Light", size: 16))
                            }
                        }
                    }
                }
            )
    }
}

struct RegenOrGoodButtons: View {
    
    var body: some View {
        HStack {
            Button(action: {
                print("Generate button tapped")
            }) {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(UIColor.darkGray), lineWidth: 3)
                    .fill(Color.white)
                    .frame(width: UIScreen.main.bounds.width - 225, height: 50)
                    .overlay(
                        Text("Regenerate")
                            .foregroundColor(Color(UIColor.darkGray))
                            .font(.custom("Poppins-Light", size: 16))
                    )
        }
            Button(action: {
                print("Looks good button tapped")
            }) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 35/255, green: 109/255, blue: 97/255))
                    .frame(width: UIScreen.main.bounds.width - 225, height: 50)
                    .overlay(
                        Text("Looks good")
                            .foregroundColor(Color.white)
                            .font(.custom("Poppins-Light", size: 16))
                    )
            }
        }
    }
}

struct PulseHelperResponseStructs_Previews: PreviewProvider {
    @State static var text = ""
    static var previews: some View {
        VStack {
            ImportFileButton()
            Divider()
            RegenOrGoodButtons()
        }
    }
}
