//
//  SpecialLocationDetailsModel.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-06-18.
//

import Foundation

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
