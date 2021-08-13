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

struct EmployeeInfoModel: Codable {
    let user: User
    let status: Int
    let data: EmployeeInfoData
    let welcomeDescription: String

    enum CodingKeys: String, CodingKey {
        case user, status, data
        case welcomeDescription = "description"
    }
}

struct EmployeeInfoData: Codable {
    let employeeId: String
    let fullName: String
    let nameWithInitials: String
    let otherName: String
    let residentialAddress1: String
    let residentialAddress2: String
    let residentialAddress3: String
    let residentialAddress4: String
    let permanentAddress1: String
    let permanentAddress2: String
    let permanentAddress3: String
    let permanentAddress4: String
    let districtCodeRes: String
    let districtCodePer: String
    let postalCodeRes: String
    let postalCodePer: String
    let telNo1Res: String
    let telNo2Res: String
    let telNo1Per: String
    let telNo2Per: String
    let email: String
    let payAccountNo: String
    let bankCode: String
    let taxStatus: String
    let taxNumber: String
    let epfStatus: String
    let epfNumber: String
    let etfStatus: String
    let etfNumber: String
    let madeOfPayment: String
    let citizen: String
    let nationality: String
    let sex: String
    let race: String
    let dateOfBirth: String
    let dateOfJoin: String
    let dateConfirmed: String
    let dateOfResign: String
    let ageOfRetirement: String
    let maritalStatus: String
    let religion: String
    let nic: String
    let postalId: String
    let postalIdExpDate: String
    let bloodGroup: String
    let contractFrom: String
    let contractTo: String
    let passportNumber: String
    let passportExpDate: String
    let getDrivingLicenseNumber: String
    let drivingLicenseExpDate: String
    let effectiveDate: String
    let employeeType: String
    let occupationGroup: String
    let salaryGrade: String
    let designation: String
    let jobTitle: String
    let basicSalary: String
    let leaveType: String
    let branchId: String
    let district: String
    let departmentId: String
    let section: String
    let eligibleForOt: String
    let unionMember: String
    let unionCode: String
    let unionRegisterNo: String
    let officeTel: String
    let officeExt: String
    let branchShortName: String
    let branchLongName: String
    let departmentShortName: String
    let departmentLongName: String
    
    enum CodingKeys: String, CodingKey {
        case employeeId, fullName, nameWithInitials, otherName
        case residentialAddress1, residentialAddress2, residentialAddress3, residentialAddress4
        case permanentAddress1, permanentAddress2, permanentAddress3, permanentAddress4
        case districtCodeRes, districtCodePer, postalCodeRes, postalCodePer
        case telNo1Res, telNo2Res
        case telNo1Per, telNo2Per
        case email, payAccountNo, bankCode
        case taxStatus, taxNumber
        case epfStatus, epfNumber, etfStatus, etfNumber
        case madeOfPayment, citizen, nationality, sex, race
        case dateOfBirth, dateOfJoin, dateConfirmed, dateOfResign
        case ageOfRetirement, maritalStatus, religion, nic
        case postalId, postalIdExpDate
        case bloodGroup
        case contractFrom, contractTo
        case passportNumber, passportExpDate, getDrivingLicenseNumber, drivingLicenseExpDate
        case effectiveDate, employeeType
        case occupationGroup, salaryGrade
        case designation, jobTitle
        case basicSalary
        case leaveType
        case branchId
        case district
        case departmentId
        case section
        case eligibleForOt
        case unionMember, unionCode
        case unionRegisterNo
        case officeTel, officeExt
        case branchShortName, branchLongName
        case departmentShortName, departmentLongName
    }
}
