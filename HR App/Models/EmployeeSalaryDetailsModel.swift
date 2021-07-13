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
    let branch: String
    let department: String
    let eligibleForOt, incrementYear, incrementMonth, additionalDate: String
    let effectiveDate: String
}

