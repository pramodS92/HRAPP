//
//  CoporateManagementDetailsModel.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-06-20.
//

import Foundation

struct CoporateManagementDetailsModel: Codable {
    let user: User?
    let status: Int?
    let data: BranchEmployeeData?
    let welcomeDescription: String?

    enum CodingKeys: String, CodingKey {
        case user, status, data
        case welcomeDescription = "description"
    }
}
