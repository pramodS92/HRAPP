//
//  CoporateManagementDetailsServiceManager.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-06-20.
//

import Foundation

protocol onSuccessCoporateManagementDetails {
    func getCoporateManagementInfo(coporateManagementEmployeeName: String, coporateManagementInfo: [String], coporateManagemenData: BranchEmployeeData)
    func onFailier()
}

class CoporateManagementDetailsService {
    
    var userInfo: [String] = []
    var userTableData: [String] = []
    var delegate: onSuccessCoporateManagementDetails?
    let unavailable = KeyCostants.BranchEmployeeDetails.TEXT_UNAVAILABLE
    
    public func getCoporateManagementDetailsById(employeeId: String, _ callback: onSuccessCoporateManagementDetails) {
        self.delegate = callback
        CoporateManagementInfoService.shared.getCoporateManagementById(employeeId: employeeId) { (response, error, statusCode) in
            if response != nil {
                if let responseBody = try? JSONDecoder().decode(CoporateManagementDetailsModel.self, from: response! as! Data) {
                    
                    if let coporateManagementData = responseBody.data {
                        self.delegate?.getCoporateManagementInfo(coporateManagementEmployeeName: coporateManagementData.fullName!, coporateManagementInfo: self.getCoporateManagementDetails(response: coporateManagementData), coporateManagemenData:  coporateManagementData)
                        
                    }
                }
            } else {
                self.delegate?.onFailier()
                return
            }
        }
    }
    
    //Get selected employee profile details  - User Profile Module
    func getCoporateManagementDetails(response: BranchEmployeeData) -> [String] {
        userInfo.removeAll()
        userInfo.append(response.name!.condensed.uppercased())
        userInfo.append(response.designation ?? "Designation")
        userInfo.append(response.branch!)
        userInfo.append(response.telephone ?? "telephone number")
        userInfo.append(response.interCOM ?? "intercom")
        userInfo.append(response.email ?? "email")
        
        return userInfo
    }
    
    //Get selected employee details in UserInfo Tab - User Profile Module
    func getEmployeeTableData(response: BranchEmployeeData) -> [String]{
        userTableData.removeAll()
        let namesArray: [String]! = response.name?.components(separatedBy: " ")
        var initilas: String = ""
        for (index,name) in namesArray.enumerated() {
            if index > 1 {
                initilas += name.prefix(1) + " "
            }
        }
        
        userTableData.append(initilas.condensed.uppercased())
        userTableData.append(response.knownName!)
        userTableData.append(response.knownName!)
        userTableData.append(response.name!.condensed.uppercased())
        userTableData.append(unavailable)
        userTableData.append(response.employeeID! )
        
        return userTableData
    }
    
}
