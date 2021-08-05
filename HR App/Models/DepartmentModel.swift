//
//
// DepaetmentNameListModel.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/24/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import Foundation


struct DepartmentNameListModel: Codable {
    let user: User
    let status: Int
    let data: [DepartmentData]?
    let welcomeDescription: String

    enum CodingKeys: String, CodingKey {
        case user, status, data
        case welcomeDescription = "description"
    }
}


struct DepartmentData: Codable {
    let departmentName, departmentID, addressOne, addressTwo: String
    let addressThree, addressFour: String

        enum CodingKeys: String, CodingKey {
            case departmentName
            case departmentID = "departmentId"
            case addressOne, addressTwo, addressThree, addressFour
        }
}

struct DepartmentDetailsModel: Codable {
    let user: User?
    let status: Int?
    let data: DepartmentDataClass?
    let welcomeDescription: String?

    enum CodingKeys: String, CodingKey {
        case user, status, data
        case welcomeDescription = "description"
    }
}


struct DepartmentDataClass: Codable {
    let departmentName: String?
    let departmentID, fax, deparmentHead, knownName: String?
    let departmentHeadID, deparmentHeadTelephone, headEXT: String?
    let branchName: String?
    let agmName, agmEmpCode, agmDetails: String?
    let addressOne, addressTwo, addressThree, addressFour: String?
    let branchEmployees: [BranchEmployeeData]?

    enum CodingKeys: String, CodingKey {
        case departmentName
        case departmentID = "departmentId"
        case agmName
        case agmEmpCode
        case agmDetails
        case fax, deparmentHead, knownName, departmentHeadID, deparmentHeadTelephone, headEXT, branchName, addressOne, addressTwo, addressThree, addressFour, branchEmployees
    }
}
