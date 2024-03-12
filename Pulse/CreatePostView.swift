import SwiftUI

struct CreatePostView: View {
    @State private var subjectText: String = ""
    @State private var bodyText: String = ""
    var body: some View {
        ZStack {
            Color(UIColor.systemGray5)
                .ignoresSafeArea()
            VStack {
                HStack(spacing: -20) {
                    Button(action: {
                        print("Going back")
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color(UIColor.systemGray))
                    }
                    .padding()
                    Text("Create a post")
                        .font(.custom("Poppins-Medium", size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
                TypeInSubject(subjectText: $subjectText) //find in structs_textFields
                    .padding(.vertical, -10)
                VStack(spacing: 0) {
                    Text("Tags")
                        .font(.custom("Poppins-Medium", size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)
                    AllTagButtons() //find in structs_buttons
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 10)
                }
                
                VStack(spacing: 5) {
                    Button(action: {
                        print("Info button tapped")
                    }) {
                        Image(systemName: "info.circle")
                            .foregroundColor(Color(UIColor.darkGray))
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal, 10)
QuestionTextfield(height: 200, question: "Please describe in details the issue you want to resolve", text: $bodyText)
                }

                Spacer()
                HStack {
                    Text("min 1000 chars")
                        .font(.custom("Poppins-Medium", size: 14))
                        .foregroundColor(Color(UIColor.darkGray))
                        .padding(.leading, 10)
                    Spacer()
                    AIButton() //find in structs_buttons
                        .padding(.trailing, 10)
                }
                ImportFileButton() //find in structs_buttons
                Button(action: {
                    print("Post button tapped")
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(UIColor.darkGray))
                        .frame(width: UIScreen.main.bounds.width - 20, height: 50)
                        .overlay(
                            Text("Post")
                                .foregroundColor(Color.white)
                                .font(.custom("Poppins-Medium", size: 16))
                        )
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