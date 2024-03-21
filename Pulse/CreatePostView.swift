import SwiftUI

struct CreatePostView: View {
    @State private var isSheetPresented = false
    @State private var subjectText: String = ""
    @State private var bodyText: String = ""
    var body: some View {
        ZStack {
            Color(UIColor.systemGray5)
                .ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Text("Create a post")
                        .font(.custom("Poppins-Light", size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                    TypeInSubject(subjectText: $subjectText)
                        .padding(.vertical, -10)
                    VStack(spacing: 0) {
                        Text("Tags")
                            .font(.custom("Poppins-Light", size: 24))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 24)
                        AllTagButtons() //implemented in HomeStructs
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 12)
                    }
                    
                    VStack(spacing: 5) {
                        Button(action: {
                            print("Info button tapped")
                        }) {
                            Image(systemName: "info.circle")
                                .foregroundColor(Color(UIColor.darkGray))
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 24)
    QuestionTextfield(height: 200, question: "Please describe in details the issue you want to resolve", text: $bodyText)
                    }

                    Spacer()
                    HStack {
                        Text("min 1000 chars")
                            .font(.custom("Poppins-Light", size: 14))
                            .foregroundColor(Color(UIColor.darkGray))
                            .padding(.leading, 24)
                        Spacer()
                        AIButton()
                            .padding(.trailing, 24)
                    }
                    .padding(.vertical, 4)
                    ImportFileButton()
                    Button(action: {
                        print("Post button tapped")
                    }) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(red: 35/255, green: 109/255, blue: 97/255))
                            .frame(width: UIScreen.main.bounds.width - 45, height: 50)
                            .overlay(
                                Text("Post")
                                    .foregroundColor(Color.white)
                                    .font(.custom("Poppins-Light", size: 16))
                            )
                    }
                }
            }
        }
    }
}

struct createPost_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView()
    }
}
