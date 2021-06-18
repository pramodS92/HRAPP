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
