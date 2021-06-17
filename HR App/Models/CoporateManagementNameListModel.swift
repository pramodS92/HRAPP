//
//  CoporateManagementNameListModel.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-06-17.
//

import Foundation

struct CoporateManagementNameListModel: Codable {
    let user: User?
    let status: Int?
    let data: [CoporateManagementData]?
    let welcomeDescription: String?

    enum CodingKeys: String, CodingKey {
        case user, status, data
        case welcomeDescription = "description"
    }
}

// MARK: - Datum
struct CoporateManagementData: Codable {
    let knownName, directNumber, interCOM: String?
    let secretaryInterCOM: String?
    let countryCode: String?
    let designation, agmid, secretaryID, name: String?

    enum CodingKeys: String, CodingKey {
        case knownName, directNumber
        case interCOM = "interCom"
        case secretaryInterCOM = "secretaryInterCom"
        case countryCode, designation, agmid
        case secretaryID = "secretaryId"
        case name
    }
}
