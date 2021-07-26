//
//  SpecialLocationNameListModel.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-06-18.
//

import Foundation

struct SpecialLocationNameListModel: Codable {
    let user: User?
    let status: Int?
    let data: [SpecialLocationData]?
    let welcomeDescription: String?

    enum CodingKeys: String, CodingKey {
        case user, status, data
        case welcomeDescription = "description"
    }
}

// MARK: - Datum
struct SpecialLocationData: Codable {
    let locationName, locationID: String?

    enum CodingKeys: String, CodingKey {
        case locationName
        case locationID = "locationId"
    }
}

struct SpecialLocationDetailsModel: Codable {
    let user: User?
    let status: Int?
    let data: SpecialLocationDataClass?
    let welcomeDescription: String?

    enum CodingKeys: String, CodingKey {
        case user, status, data
        case welcomeDescription = "description"
    }
}

// MARK: - DataClass
struct SpecialLocationDataClass: Codable {
    let locationName, locationID, attachedBranch, fax: String?
    let designationOne, designationTwo, nameOne, nameTwo: String?
    let directNumberOne, directNumberTwo, interComeOne, interComeTwo: String?

    enum CodingKeys: String, CodingKey {
        case locationName
        case locationID = "locationId"
        case attachedBranch, fax, designationOne, designationTwo, nameOne, nameTwo, directNumberOne, directNumberTwo, interComeOne, interComeTwo
    }
}
