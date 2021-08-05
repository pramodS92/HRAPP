//
//
// EmployeeNameListModel.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/28/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import Foundation


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

// MARK: - EmployeeSalaryDetailsModel
struct EmployeeSalaryDetailsModel: Codable {
    let user: User
    let status: Int
    let data: [EmployeeSalaryDetailsData]
    let welcomeDescription: String

    enum CodingKeys: String, CodingKey {
        case user, status, data
        case welcomeDescription = "description"
    }
}

// MARK: - Datum
struct EmployeeSalaryDetailsData: Codable {
    let salaryGrade, basicSalary: String
    let branch: String
    let department: String
    let eligibleForOt, incrementYear, incrementMonth, additionalDate: String
    let effectiveDate: String
}

struct EmployeeTransferHistoryModel: Codable {
    let user: User
    let status: Int
    let data: [EmployeeTransferHistoryData]
    let welcomeDescription: String

    enum CodingKeys: String, CodingKey {
        case user, status, data
        case welcomeDescription = "description"
    }
}

struct EmployeeTransferHistoryData: Codable {
    let effectedOn, reasonForChange: String
        let employeeType: String
        let branchCode: String
        let branchName: String
        let branchTel: String
        let departmentName: String
        let departmentTel, departmentID, reason, designation: String

        enum CodingKeys: String, CodingKey {
            case effectedOn, reasonForChange, employeeType, branchCode, branchName, branchTel, departmentName, departmentTel
            case departmentID = "departmentId"
            case reason, designation
        }
}
