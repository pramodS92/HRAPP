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
    let knownName, directNumber, interCom: String?
    let secretaryInterCom: String?
    let countryCode: String?
    let designation, agmId, secretaryID, name: String?

    enum CodingKeys: String, CodingKey {
        case knownName, directNumber
        case interCom
        case secretaryInterCom
        case countryCode, designation, agmId
        case secretaryID = "secretaryId"
        case name
    }
}
