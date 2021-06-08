//
//
// EmployeeNameListModel.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/28/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import Foundation


// MARK: - Welcome
struct EmployeeNameListModel: Codable {
    let user: User?
    let status: Int?
    let data: [BranchEmployeeData]?
    let welcomeDescription: String?

    enum CodingKeys: String, CodingKey {
        case user, status, data
        case welcomeDescription = "description"
    }
}

