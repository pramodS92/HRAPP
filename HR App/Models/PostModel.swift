//
//  PostModel.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-07-31.
//

import Foundation

// MARK: - Welcome
struct PostModel: Codable {
    let user: User?
    let status: Int?
    let data: [PostData]?
    let welcomeDescription: String?

    enum CodingKeys: String, CodingKey {
        case user, status, data
        case welcomeDescription = "description"
    }
}

// MARK: - Datum
struct PostData: Codable {
    let id: String?
    let createdDate: String?
    let url: String?
    let type: String?
    let approvedDate, deleteDate: String?
    let piority: String?
    let approvedBy: String?
    let department, branch: String?
    let status, react, share, comment: String?
    let description, lastModifyDate: String?
    let canShare: String?
    let profileURL: String?
    let profileShortName, profileLongName: String?
    let group: Group?
    let createdBy: CreatedBy?

    enum CodingKeys: String, CodingKey {
        case id, createdDate, url, type, approvedDate, deleteDate, piority, approvedBy, department, branch, status, react, share, comment
        case description
        case lastModifyDate, canShare
        case profileURL = "profileUrl"
        case profileShortName, profileLongName, group, createdBy
    }
}

// MARK: - CreatedBy
struct CreatedBy: Codable {
    let id: String?
    let userID: String?
    let type: String?
    let profilePicURL: String?
    let token: String?
    let status: String?
    let shortName, longName: String?
    let mobile: String?
    let groupID: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case type
        case profilePicURL = "profilePicUrl"
        case token, status, shortName, longName, mobile
        case groupID = "groupId"
    }
}

struct Group: Codable {
    let id: String?
    let groupID: String?
    let type: String?
    let profilePicURL: String?
    let token: String?
    let status: String?
    let shortName, longName: String?
    

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case profilePicURL = "profilePicUrl"
        case token, status, shortName, longName
        case groupID = "groupId"
    }
}

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
