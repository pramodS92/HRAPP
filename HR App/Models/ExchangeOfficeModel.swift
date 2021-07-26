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

struct ExchangeOfficeDetailsModel: Codable {
    let user: User?
    let status: Int?
    let data: ExchangeOfficeDataClass?
    let welcomeDescription: String?

    enum CodingKeys: String, CodingKey {
        case user, status, data
        case welcomeDescription = "description"
    }
}

// MARK: - DataClass
struct ExchangeOfficeDataClass: Codable {
    let departmentName, departmentID, fax, deparmentHead: String?
    let knownName, departmentHeadID, deparmentHeadTelephone, headEXT: String?
    let branchName, aGMName, aGMEmpcode, aGMDetails: String?
    let address1, address2, address3, address4: String?
    let branchEmployees: [BranchEmployeeData]?

    enum CodingKeys: String, CodingKey {
        case departmentName
        case departmentID = "departmentId"
        case fax, deparmentHead, knownName, departmentHeadID, deparmentHeadTelephone, headEXT, branchName
        case aGMName = "aGM_Name"
        case aGMEmpcode = "aGM_Empcode"
        case aGMDetails = "aGM_Details"
        case address1, address2, address3, address4, branchEmployees
    }
}
