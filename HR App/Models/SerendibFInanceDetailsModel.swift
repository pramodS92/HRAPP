//
//  SerendibFInanceDetailsModel.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-06-17.
//

import Foundation

struct SerendibFinanceDetailsModel: Codable {
    let user: User?
    let status: Int?
    let data: SerendibFinanceDataClass?
    let welcomeDescription: String?

    enum CodingKeys: String, CodingKey {
        case user, status, data
        case welcomeDescription = "description"
    }
}

// MARK: - DataClass
struct SerendibFinanceDataClass: Codable {
    let departmentName: String?
    let departmentID, fax, deparmentHead, knownName: String?
    let departmentHeadID, deparmentHeadTelephone, headEXT: String?
    let branchName: String?
    let aGMName, aGMEmpcode, aGMDetails, address1: String?
    let address2, address3, address4: String?
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
