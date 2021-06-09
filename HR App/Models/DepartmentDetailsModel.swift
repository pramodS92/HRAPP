//
//
// DepartmentDetailsModel.swift
// HR App
//
//Created by Pramod Ranasinghe on 6/9/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import Foundation



struct DepartmentDetailsModel: Codable {
    let user: User
    let status: Int
    let data: DepartmentDataClass
    let welcomeDescription: String

    enum CodingKeys: String, CodingKey {
        case user, status, data
        case welcomeDescription
    }
}


struct DepartmentDataClass: Codable {
    let departmentName: String?
    let departmentID, fax, deparmentHead, knownName: String
    let departmentHeadID, deparmentHeadTelephone, headEXT: String
    let branchName: String?
    let address1, address2, address3, address4: String?
    let branchEmployees: [BranchEmployee]

    enum CodingKeys: String, CodingKey {
        case departmentName
        case departmentID = "departmentId"
        case fax, deparmentHead, knownName, departmentHeadID, deparmentHeadTelephone, headEXT, branchName, address1, address2, address3, address4, branchEmployees
    }
}


struct BranchEmployee: Codable {
    let name, fullName, employeeID, knownName: String?
    let gender: String?
    let designation, email, telephone, interCOM: String?
    let imageURL: String?
    let branch: String
    let department: String

    enum CodingKeys: String, CodingKey {
        case name, fullName
        case employeeID = "employeeId"
        case knownName, gender, designation, email, telephone
        case interCOM
        case imageURL
        case branch, department
    }
}


