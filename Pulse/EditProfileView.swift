//  ProfileView.swift

import SwiftUI

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var oldPw: String = ""
    @State private var newPw: String = ""
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGray5)
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        HStack(spacing: -20) {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(Color(UIColor.systemGray))
                            }
                            .padding()
                            Text("Edit Profile")
                                .font(.custom("Poppins-Light", size: 24))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                        }
                        Circle()
                            .frame(width: 200)
                            .padding(.horizontal, 8)
                            .foregroundColor(Color(UIColor.darkGray))
                        Text("Edit picture")
                            .font(.custom("Poppins-Light", size: 16))
                        HStack {
                            Text("Name")
                                .font(.custom("Poppins-Light", size: 21))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            TextField_Lined(defaultString: "", text: $name)
                            
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        HStack {
                            Text("Neighborhood")
                                .font(.custom("Poppins-Light", size: 21))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            TextField_Lined(defaultString: "dropdown", text: $email)
                            
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        HStack {
                            Text("Email")
                                .font(.custom("Poppins-Light", size: 21))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            TextField_Lined(defaultString: "", text: $email)
                            
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        HStack {
                            Text("Password")
                                .font(.custom("Poppins-Light", size: 21))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            SecureField_Lined(defaultString: "Current password", text: $oldPw)
                            
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        HStack {
                            Text(".")
                                .font(.custom("Poppins-Light", size: 21))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            SecureField_Lined(defaultString: "New password", text: $newPw)
                            
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}


#Preview {
    EditProfileView()
}
