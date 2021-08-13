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
    let locationName, locationID: String
        let attachedBranch: String
        let fax, designationOne: String
        let designationTwo: String
        let nameOne: String
        let nameTwo: String
        let directNumberOne, directNumberTwo, interComeOne, interComeTwo: String
        let addressOne: String
        let addressTwo: String
        let addressThree: String
        let addressFour: String

        enum CodingKeys: String, CodingKey {
            case locationName
            case locationID = "locationId"
            case attachedBranch, fax, designationOne, designationTwo, nameOne, nameTwo, directNumberOne, directNumberTwo, interComeOne, interComeTwo, addressOne, addressTwo, addressThree, addressFour
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
    let locationName, locationID, attachedBranch, fax: String
        let designationOne, designationTwo, nameOne, nameTwo: String
        let directNumberOne, directNumberTwo, interComeOne, interComeTwo: String

        enum CodingKeys: String, CodingKey {
            case locationName
            case locationID = "locationId"
            case attachedBranch, fax, designationOne, designationTwo, nameOne, nameTwo, directNumberOne, directNumberTwo, interComeOne, interComeTwo
        }
}
