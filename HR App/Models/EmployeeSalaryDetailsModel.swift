//
//  EmployeeSalaryDetailsModel.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-06-29.
//

import Foundation

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
    let branch: Branch
    let department: Department
    let eligibleForOt, incrementYear, incrementMonth, additionalDate: String
    let effectiveDate: String
}

enum Branch: String, Codable {
    case foreignBranch = "FOREIGN BRANCH"
    case headOffice = "HEAD OFFICE"
}

enum Department: String, Codable {
    case corporateBankingUnit = "CORPORATE BANKING UNIT"
    case empty = "."
    case marketingDepartment = "MARKETING DEPARTMENT"
    case retailCreditDept = "RETAIL CREDIT DEPT."
    case secretariesUnit = "SECRETARIES UNIT"
}
