//
//
// UserDetailsModel.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/18/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.

import Foundation

// MARK: - UserDetailsModel
struct UserDetailsModel: Codable {
    let user: User?
    let status: Int?
    let data: DataClass?
    let welcomeDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case user, status, data
        case welcomeDescription
    }
}



struct DataClass: Codable {
    let employeeID, knownName, gender, designation: String?
    let email, telephone, interCOM, imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case employeeID
        case knownName, gender, designation, email, telephone
        case interCOM
        case imageURL
    }
}






// MARK: - User
struct User: Codable {
    let id, name: String?
    let givenName: String?
    let preferredUsername: String?
    let exp: String?
    let sessionState, familyName, email: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case preferredUsername = "preferred_username"
        case givenName = "given_name"
        case name, exp
        case sessionState
        case familyName = "family_name"
        case email
    }
}
