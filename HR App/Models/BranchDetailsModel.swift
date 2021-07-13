//
//
// BranchDetailsModel.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/25/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import Foundation


struct BranchDetailsModel: Codable {
    let user: User
    let status: Int
    let data: [BranchData]?
    let welcomeDescription: String?

    enum CodingKeys: String, CodingKey {
        case user, status, data
        case welcomeDescription = "description"
    }
}

// MARK: - Datum
struct BranchData: Codable {
    let branchName: String?
    let branchID, address1, address2, address3: String?
    let address4, telephone, fax, managerID: String?
    let managerTelephone, managerName, managerKnowName, regionalOffice: String?
    let regionalManagerName, regionalManagerEmpcode, aGM, aGMID: String?
    let aGMDesignation: String?
    let branchEmployees: [BranchEmployeeData]?

    enum CodingKeys: String, CodingKey {
        case branchName
        case branchID = "branchId"
        case address1, address2, address3, address4, telephone, fax, managerID, managerTelephone, managerName, managerKnowName, regionalOffice, regionalManagerName, regionalManagerEmpcode, aGM
        case aGMID = "aGM_ID"
        case aGMDesignation = "aGM_designation"
        case branchEmployees
    }
}



// MARK: - BranchEmployee
struct BranchEmployeeData: Codable {
    let name,fullName, employeeID, knownName: String?
    let gender: String?
    let designation: String?
    let email: String?
    let telephone: String?
    let interCOM: String?
    let imageURL: String?
    let branch: String?
    let department: String?

    enum CodingKeys: String, CodingKey {
        case name,fullName
        case employeeID = "employeeId"
        case knownName, gender, designation, email, telephone
        case interCOM = "interCom"
        case imageURL
        case branch, department
    }
}



