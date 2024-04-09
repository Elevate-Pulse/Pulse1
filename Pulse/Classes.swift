//  classes.swift

import SwiftUI

extension Color {
    static let greenColor = Color(red: 35/255, green: 109/255, blue: 97/255)
}

class User: Identifiable, Codable {
    var id: String
    var name: String
    var email: String
    var timesLoggedIn: Int
    var initialSurvey: Bool
    var socialCurrentProgress: Int
    var surroundingsCurrentProgress: Int
    var convenienceCurrentProgress: Int
    var securityCurrentProgress: Int
    var engagementCurrentProgress: Int
    var socialLvl: Int
    var surroundingsLvl: Int
    var convenienceLvl: Int
    var securityLvl: Int
    var engagementLvl: Int
    
    init(id: String, name: String, email: String, timesLoggedIn: Int, initialSurvey: Bool, socialCurrentProgress: Int, surroundingsCurrentProgress: Int, convenienceCurrentProgress: Int, securityCurrentProgress: Int, engagementCurrentProgress: Int, socialLvl: Int, surroundingsLvl: Int, convenienceLvl: Int, securityLvl: Int, engagementLvl: Int) {
        self.id = id
        self.name = name
        self.email = email
        self.timesLoggedIn = timesLoggedIn
        self.initialSurvey = initialSurvey
        self.socialCurrentProgress = socialCurrentProgress
        self.surroundingsCurrentProgress = surroundingsCurrentProgress
        self.convenienceCurrentProgress = convenienceCurrentProgress
        self.securityCurrentProgress = securityCurrentProgress
        self.engagementCurrentProgress = engagementCurrentProgress
        self.socialLvl = socialLvl
        self.surroundingsLvl = surroundingsLvl
        self.convenienceLvl = convenienceLvl
        self.securityLvl = securityLvl
        self.engagementLvl = engagementLvl
    }
}


struct Classes: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    Classes()
}
