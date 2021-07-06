//
//
// EmployeeDetailsModel.swift
// HR App
//
//Created by Pramod Ranasinghe on 6/1/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import Foundation

struct EmployeeDetailsModel: Codable {
    let user: User?
    let status: Int?
    let data: BranchEmployeeData?
    let welcomeDescription: String?

    enum CodingKeys: String, CodingKey {
        case user, status, data
        case welcomeDescription = "description"
    }
}


struct EmployeeDetials: Codable {
    let name, fullName, employeeID, knownName, gender: String?
    let designation, email, telephone, interCOM: String?
    let imageURL: String?
    let branch, department: String?

    enum CodingKeys: String, CodingKey {
        case name, fullName
        case employeeID = "employeeId"
        case knownName, gender, designation, email, telephone
        case interCOM = "interCom"
        case imageURL
        case branch, department
    }
}

