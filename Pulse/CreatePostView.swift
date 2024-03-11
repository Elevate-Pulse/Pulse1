import SwiftUI

struct CreatePostView: View {
    @State private var subjectText: String = ""

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
                        .font(.system(size: 25))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
                
                TypeInSubject(subjectText: $subjectText) //find in structs_textFields
                
                VStack(spacing: 10) {
                    Text("Tags")
                        .font(.system(size: 25))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)
                    AllTagButtons() //find in structs_buttons
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)
                }
                
                HStack(spacing: 0) {
                    Text("Please describe in details the issue you want to resolve")
                        .foregroundColor(Color(UIColor.darkGray))

                    Button(action: {
                        print("Info button tapped")
                    }) {
                        Image(systemName: "info.circle")
                            .foregroundColor(Color(UIColor.darkGray))
                    }
                }
                
                
                

                Spacer()
                HStack {
                    Text("min 1000 chars")
                        .font(.system(size: 15))
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
