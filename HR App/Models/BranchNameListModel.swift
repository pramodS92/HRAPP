//
//
// BranchNameListModel.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/22/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import Foundation

// MARK: - BranchNameListModel
struct BranchNameListModel: Codable {
    let user: User
    let status: Int
    let data: [Datum]?
    let welcomeDescription: String

    enum CodingKeys: String, CodingKey {
        case user, status, data
        case welcomeDescription = "description"
    }
}

// MARK: - Datum
struct Datum: Codable {
    let branchName, branchID: String?

    enum CodingKeys: String, CodingKey {
        case branchName
        case branchID
    }
}




