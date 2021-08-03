//
//  PostModel.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-07-31.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
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
    let id, cruser, crdt, url: String
    let type, aprovdt, deldat, piority: String
    let approBy, deprt, branch, status: String
    let react, share, comment, datumDescription: String
    let lasmoddt, canShare: String

    enum CodingKeys: String, CodingKey {
        case id, cruser, crdt, url, type, aprovdt, deldat, piority, approBy, deprt, branch, status, react, share, comment
        case datumDescription = "description"
        case lasmoddt, canShare
    }
}
