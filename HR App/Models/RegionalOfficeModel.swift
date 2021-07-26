//
//  RegionalOfficeNameListModel.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-06-16.
//

import Foundation

// MARK: - RegionalOfficeNameListModel
struct RegionalOfficeNameListModel: Codable {
    let user: User?
    let status: Int?
    let data: [RegionalOfficeData]?
    let welcomeDescription: String?

    enum CodingKeys: String, CodingKey {
        case user, status, data
        case welcomeDescription = "description"
    }
}

// MARK: - Datum
struct RegionalOfficeData: Codable {
    let regionalOffice, regionalOfficeIDs: String?
}

struct RegionalOfficeDetailsModel: Codable {
    let user: User?
    let status: Int?
    let data: RegionalOfficeDataClass?
    let welcomeDescription: String?

    enum CodingKeys: String, CodingKey {
        case user, status, data
        case welcomeDescription = "description"
    }
}

// MARK: - DataClass
struct RegionalOfficeDataClass: Codable {
    let regionalOffice, regionalOfficeIDs, regionCode, attachedBranch: String?
    let location, fax, aGMName, aGMID: String?
    let aGMDesignation, regionalManagerName, regionalManagerKnownName, regionalManagerTP: String?
    let regionalManagerEXT, subdivision: String?
    let employeeDetails: [BranchEmployeeData]?
}
