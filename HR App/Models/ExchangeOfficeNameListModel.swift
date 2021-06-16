//
//  ExchangeOfficeNameListModel.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-06-16.
//

import Foundation

// MARK: - ExchangeOfficeNameListModel
struct ExchangeOfficeNameListModel: Codable {
    let user: User
    let status: Int
    let data: [ExchangeOfficeData]?
    let welcomeDescription: String

    enum CodingKeys: String, CodingKey {
        case user, status, data
        case welcomeDescription = "description"
    }
}

// MARK: - Datum
struct ExchangeOfficeData: Codable {
    let departmentName, departmentID: String?

    enum CodingKeys: String, CodingKey {
        case departmentName
        case departmentID = "departmentId"
    }
}
