//  structs_buttons.swift
/*
 structs included:
 -AIButton: button for pulse helper
 -TagButton: a single button for a tag
 -AllTagButtons: every tag combined in the horizontal scrollview
 -ImportFileButton: button to allow import of links, media, polls
 -StylePickerButton: dropdown menu to pick style of how the ai should generate response
 -GenerateButton: button to tap on after filling in question for ai in PulseHelperViewQuestionsView
 -RegenOrGoodButtons: Regenerate or Looks Good after AI generates response
 */
import SwiftUI

struct AIButton: View {
    @State private var showPHQV = false
    var body: some View {
        Button(action: {
            print("AI generator tapped")
            
            showPHQV = true
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 50).stroke(Color(UIColor.darkGray), lineWidth: 2)
                    .frame(width: 175, height: 40)
                HStack {
                    Image(systemName: "bolt.heart")
                        .foregroundColor(Color.black)
                    Text("Pulse Assistant")
                        .foregroundColor(Color(UIColor.darkGray))
                        .font(.custom("Poppins-Light", size: 16))
                }
            }
        }
        .sheet(isPresented: $showPHQV) {
            PulseHelperQuestionnaireView()
        }
    }
}


struct TagButton: View {
    let tag: String
    @State private var isSelected: Bool = false
    
    var body: some View {
        Button(action: {
            isSelected.toggle()
            print("tag button tapped")
        }) {
            Text(tag)
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color(UIColor.darkGray), lineWidth: 3)
                        .background(isSelected ? Color(UIColor.darkGray) : Color.clear)
                        .cornerRadius(50)
                )
                .foregroundColor(isSelected ? Color.white : Color(UIColor.darkGray))
                .font(.custom("Poppins-Light", size: 16))
        }
        .animation(.default, value: isSelected)
    }
}

struct AllTagButtons: View {
    var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    TagButton(tag: "#communityhealth")
                    TagButton(tag: "#crime")
                    TagButton(tag: "#event")
                    TagButton(tag: "#homelessness")
                    TagButton(tag: "#infrastructure")
                    TagButton(tag: "#noisepullution")
                    TagButton(tag: "#pothole")
                    TagButton(tag: "#publicspaces")
                    TagButton(tag: "#safety")
                    TagButton(tag: "#education")
                    TagButton(tag: "#shooting")
                    TagButton(tag: "#transportation")
                }
                .padding(.horizontal, 10)
            }
    }
}

struct ImportFileButton: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
            .frame(width: UIScreen.main.bounds.width - 20, height: 100)
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


struct StylePickerButton: View {
    var body: some View {
        Button(action: {
            print("Style picker Button tapped")
        }) {
            ZStack() {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(UIColor.darkGray), lineWidth: 2)
                    .frame(width: UIScreen.main.bounds.width - 20, height: 40)
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
                .fill(Color(UIColor.darkGray))
                .frame(width: UIScreen.main.bounds.width - 20, height: 50)
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


struct RegenOrGoodButtons: View {
    
    var body: some View {
        HStack {
            Button(action: {
                print("Generate button tapped")
            }) {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(UIColor.darkGray), lineWidth: 3)
                    .fill(Color.white)
                    .frame(width: UIScreen.main.bounds.width - 210, height: 50)
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
                    .fill(Color(UIColor.darkGray))
                    .frame(width: UIScreen.main.bounds.width - 210, height: 50)
                    .overlay(
                        Text("Looks good")
                            .foregroundColor(Color.white)
                            .font(.custom("Poppins-Light", size: 16))
                    )
            }
        }
    }
}

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



struct structs_buttons_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TagButton(tag: "#communityhealth")
            Divider()
            AllTagButtons()
            Divider()
            AIButton()
            Divider()
            ImportFileButton()
            Divider()
            StylePickerButton()
            Divider()
            GenerateButton(response: "ai response")
            Divider()
            RegenOrGoodButtons()
            Divider()
            EditButton()
        }
    }
}
