//
//  RegionalOfficeNameListModel.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-06-16.
//

import Foundation

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
