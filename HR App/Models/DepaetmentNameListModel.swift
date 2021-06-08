//
//
// DepaetmentNameListModel.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/24/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import Foundation


struct DepaetmentNameListModel: Codable {
    let user: User
    let status: Int
    let data: [DepartmentData]?
    let welcomeDescription: String

    enum CodingKeys: String, CodingKey {
        case user, status, data
        case welcomeDescription = "description"
    }
}

// MARK: - Datum
struct DepartmentData: Codable {
    let departmentName, departmentID: String?

    enum CodingKeys: String, CodingKey {
        case departmentName
        case departmentID
    }
}
