//
//
// UserProfileServiceManager.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/30/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import Foundation
import Alamofire

protocol OnSuccessUserProfile {
    func OnSuccessUserProfile(userInfo: [String],userTabelData: [String])
    func getEmployeeSalaryInfo(employeeSalaries: [EmployeeSalaryDetailsData])
    func getEmployeeTransferHistoryInfo(employeeTransferHistory: [EmployeeTransferHistoryData])
    func getUserData(userData: BranchEmployeeData)
    func onFailier()
}

class UserProfileServiceManager {
    
    var userInfo: [String] = []
    var userTableData: [String] = []
    var effectiveDates: [Date] = []
    var userSalaryTableData: [EmployeeSalaryDetailsData] = []
    var userTransferHistoryTableData: [EmployeeTransferHistoryData] = []
    var delegate: OnSuccessUserProfile?
    let unavailable = KeyCostants.BranchEmployeeDetails.TEXT_UNAVAILABLE
    
    static  let isoFormatter : ISO8601DateFormatter = {
        let formatter =  ISO8601DateFormatter()
            formatter.formatOptions = [.withFullDate,]
        return formatter
       }()
    
    public func getUserProfileInfo(_ callback: OnSuccessUserProfile) {
        self.delegate = callback
        UserDetailsService.shared.getUserDetails() {
            (response, error, statusCode) in
            if error != nil {
            } else {
                if response != nil {
                    if let responseBody = try? JSONDecoder().decode(UserDetailsModel.self, from: response! as! Data){
                        self.delegate?.OnSuccessUserProfile(userInfo: self.getUserDetails(response: responseBody),
                                                            userTabelData: self.getUserTabelData(response: responseBody))
                    }
                }else{
                    return
                }
            }
        }
    }
    
    public func getEmployeeDetailsById(employeeId: String, _ callback: OnSuccessUserProfile){
        self.delegate = callback
        EmployeeInfoService.shared.getEmployeeDetailsById(employeeId: employeeId) {
            (response, error, statusCode) in
            if error != nil {
            } else {
                if response != nil {
                    if let responseBody = try? JSONDecoder().decode(EmployeeDetailsModel.self, from: response! as!Data){
                        self.delegate?.OnSuccessUserProfile(userInfo: self.getEmployeeDetails(response: responseBody.data!), userTabelData: self.getEmployeeTableData(response: responseBody.data!))
                        self.delegate?.getUserData(userData: responseBody.data!)
                    }
                }else{
                    return
                }
            }
        }
    }
    
    func getEmployeeSalaryDetailsById(employeeId: String, _ callback: OnSuccessUserProfile) {
        self.delegate = callback
        
        EmployeeInfoService.shared.getEmployeeSalaryDetailsById(employeeId: employeeId) {
            (response, error, statusCode) in
            if response != nil {
                if let responseBody = try? JSONDecoder().decode(EmployeeSalaryDetailsModel.self, from: response! as! Data) {
                    print("juliet", responseBody.data)
                    self.delegate?.getEmployeeSalaryInfo(employeeSalaries: self.getEmployeeSalaryTableData(response: responseBody.data))
                }
            } else {
                self.delegate?.onFailier()
                return
            }
        }
    }
    
    func getEmployeeTransferHistoryDetailsById(employeeId: String, _ callback: OnSuccessUserProfile) {
        self.delegate = callback
        
        EmployeeInfoService.shared.getEmployeeTransferHistoryById(employeeId: employeeId) { (response, error, statusCode) in
            if response != nil {
                if let responseBody = try? JSONDecoder().decode(EmployeeTransferHistoryModel.self, from: response! as! Data) {
                    print("romeo", responseBody.data)
                    self.delegate?.getEmployeeTransferHistoryInfo(employeeTransferHistory: self.getEmployeeTransferHistoryData(response: responseBody.data))
                }
            } else {
                self.delegate?.onFailier()
                return
            }
        }
    }
    
    
    
    //Get selected employee salary details in UserJobInfo Tab - User Profile Module
    func getEmployeeSalaryTableData(response: [EmployeeSalaryDetailsData]) -> [EmployeeSalaryDetailsData] {
        self.userSalaryTableData.removeAll()
        
        // latest to oldest
        for i in 0...(response.count - 1) {
            
            var dateFromString: Date {
                return UserProfileServiceManager.isoFormatter.date(from: response[i].effectiveDate)!
            }
            
        }
        
        let sortedSalaries = response.sorted {$0.effectiveDate > $1.effectiveDate}
        self.userSalaryTableData = sortedSalaries
        
        return userSalaryTableData
    }
    
    func getEmployeeTransferHistoryData(response: [EmployeeTransferHistoryData]) -> [EmployeeTransferHistoryData] {
        self.userTransferHistoryTableData.removeAll()
        
        //latest to oldest
        for i in 0...(response.count - 1) {
            
            var dateFromString: Date {
                return UserProfileServiceManager.isoFormatter.date(from: response[i].effectedOn)!
            }
        }
        
        let sortedTransferHistory = response.sorted {$0.effectedOn > $1.effectedOn}
        self.userTransferHistoryTableData = sortedTransferHistory
        
        return userTransferHistoryTableData
    }
    
    
    
    
    //Get selected employee profile details  - User Profile Module
    func getEmployeeDetails(response: BranchEmployeeData) -> [String] {
        self.userInfo.removeAll()
        self.userInfo.append(response.name!.condensed.uppercased())
        self.userInfo.append(response.designation ?? "Designation")
        self.userInfo.append(response.branch!)
        self.userInfo.append(response.telephone ?? "telephone number")
        self.userInfo.append(response.interCOM ?? "intercom")
        self.userInfo.append(response.email ?? "email")
        
        return userInfo
    }
    
    //Get selected employee details in UserInfo Tab - User Profile Module
    func getEmployeeTableData(response: BranchEmployeeData) -> [String] {
        self.userTableData.removeAll()
        let namesArray: [String]! = response.name?.components(separatedBy: " ")
        var initilas: String = ""
        for (index,name) in namesArray.enumerated() {
            if index > 1 {
            initilas += name.prefix(1) + " "
            }
        }
        
        self.userTableData.append(initilas.condensed.uppercased())
        self.userTableData.append(response.knownName!)
        self.userTableData.append(response.knownName!)
        self.userTableData.append(response.name!.condensed.uppercased())
        self.userTableData.append(unavailable)
        self.userTableData.append(response.employeeID! )
        
        return userTableData
    }
    
    
    
    //Logged in User Profile details - User Profile Module
    func getUserDetails(response: UserDetailsModel) -> [String]{
        self.userInfo.removeAll()
        self.userInfo.append(response.user!.name!.condensed.uppercased())
        self.userInfo.append(response.data!.designation ?? "Designation")
        self.userInfo.append(response.user!.givenName!)
        self.userInfo.append(response.user!.preferredUsername!)
        self.userInfo.append(response.data?.telephone ?? "telephone number")
        self.userInfo.append(response.data?.email ?? "email")
        
        return userInfo
    }
    
    //Logged in User details in UserInfo Tab - User Profile Module
    func getUserTabelData(response: UserDetailsModel) ->[String] {
        self.userTableData.removeAll()
        let namesArray: [String]! = response.user?.name?.components(separatedBy: " ")
        var initilas: String = ""
        for name in namesArray {
            initilas += name.prefix(1) + " "
        }
        
        self.userTableData.append(initilas.condensed.uppercased())
        self.userTableData.append(response.user!.familyName!)
        self.userTableData.append(response.data!.knownName!)
        self.userTableData.append(response.user!.name!.condensed.uppercased())
        self.userTableData.append(response.user!.familyName!)
        self.userTableData.append(response.data!.employeeID! )
        
        return userTableData
    }
    
}


