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
    var personalityType: String
    
    init(id: String, name: String, email: String, timesLoggedIn: Int, initialSurvey: Bool, personalityType: String) {
        self.id = id
        self.name = name
        self.email = email
        self.timesLoggedIn = timesLoggedIn
        self.initialSurvey = initialSurvey
        self.personalityType = personalityType
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
