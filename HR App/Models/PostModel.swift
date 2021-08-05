//
//  PostModel.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-07-31.
//

import Foundation

// MARK: - Welcome
struct PostModel: Codable {
    let user: User
    let status: Int
    let data: [PostData]
    let welcomeDescription: String

    enum CodingKeys: String, CodingKey {
        case user, status, data
        case welcomeDescription = "description"
    }
}

// MARK: - Datum
struct PostData: Codable {
    let id: Int
        let createdDate, url, type, approvedDate: String
        let deleteDate: String
        let piority: Int
        let approvedBy, department, branch: String
        let status, react, share, comment: Int
        let datumDescription, lastModifyDate: String
        let canShare: Int
        let profileURL: String
        let profileShortName, profileLongName: String
        let group: Group?
        let createdBy: CreatedBy?

        enum CodingKeys: String, CodingKey {
            case id, createdDate, url, type, approvedDate, deleteDate, piority, approvedBy, department, branch, status, react, share, comment
            case datumDescription = "description"
            case lastModifyDate, canShare
            case profileURL = "profileUrl"
            case profileShortName, profileLongName, group, createdBy
        }
}

// MARK: - CreatedBy
struct CreatedBy: Codable {
    let id: Int
    let userID: String?
    let type: String
    let profilePicURL: String
    let token: String
    let status: String
    let shortName, longName: String
    let mobile: String?
    let hibernateLazyInitializer: HibernateLazyInitializer
    let groupID: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case type
        case profilePicURL = "profilePicUrl"
        case token, status, shortName, longName, mobile, hibernateLazyInitializer
        case groupID = "groupId"
    }
}

struct Group: Codable {
    let id: Int
    let groupID: String?
    let type: String
    let profilePicURL: String
    let token: String
    let status: String
    let shortName, longName: String
    let hibernateLazyInitializer: HibernateLazyInitializer
    

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case profilePicURL = "profilePicUrl"
        case token, status, shortName, longName, hibernateLazyInitializer
        case groupID = "groupId"
    }
}

// MARK: - HibernateLazyInitializer
struct HibernateLazyInitializer: Codable {
}
