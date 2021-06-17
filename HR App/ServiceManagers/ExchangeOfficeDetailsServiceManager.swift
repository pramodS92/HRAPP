//
//  ExchangeOfficeDetailsServiceManager.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-06-17.
//

import Foundation

protocol onSuccessExchangeOfficeDetails {
    func getExchangeOfficeInfo(departmentName: String, departmentInfo: [String], departmentEmployeeList: [BranchEmployeeData])
    func OnFailier()
}

class ExchangeOfficeDetailsServiceManager {
    
    var delegate: onSuccessExchangeOfficeDetails?
    var departmentData: [String] = []
    var departmentName: String?
    
}
