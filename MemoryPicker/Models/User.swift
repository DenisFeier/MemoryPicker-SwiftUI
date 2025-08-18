//
//  User.swift
//  MemoryPicker
//
//  Created by Denis Feier on 18.08.2025.
//

import Foundation
import SwiftyJSON

struct User: Identifiable {
    let id: Int
    let username: String
    let email: String
    let profilePicture: String?
    let isPublic: Bool

    init(json: JSON) {
        self.id = json["id"].intValue
        self.username = json["username"].stringValue
        self.email = json["email"].stringValue
        self.profilePicture = json["profile_picture"].string
        self.isPublic = json["is_public"].boolValue
    }
}
