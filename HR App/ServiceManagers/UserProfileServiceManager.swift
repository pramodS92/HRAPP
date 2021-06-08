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
}

class UserProfileServiceManager {
    
    var userInfo: [String] = []
    var userTableData: [String] = []
    var delegate: OnSuccessUserProfile?
    let unavailable = KeyCostants.BranchEmployeeDetails.TEXT_UNAVAILABLE
    
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
                        self.delegate?.OnSuccessUserProfile(userInfo: self.getEmployeeDetails(response: responseBody.data!),
                                                            userTabelData: self.getEmployeeTableData(response: responseBody.data!))
                    }
                }else{
                    return
                }
            }
        }
        
    }
    
    //Get selected employee details to display in top
    func getEmployeeDetails(response: EmployeeDetials) -> [String]{
        self.userInfo.removeAll()
        self.userInfo.append(response.name!.condensed.uppercased())
        self.userInfo.append(response.designation ?? "Designation")
        self.userInfo.append(response.branch!)
        self.userInfo.append(response.telephone ?? "telephone number")
        self.userInfo.append(response.interCOM! ?? "intercom")
        self.userInfo.append(response.email ?? "email")
        return userInfo
    }
    
    func getEmployeeTableData(response: EmployeeDetials) -> [String]{
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
        self.userTableData.append(response.employeeID ?? unavailable )
        
        return userTableData
    }
    
    
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
    
    
    func getUserTabelData(response: UserDetailsModel) ->[String] {
        self.userTableData.removeAll()
        let namesArray: [String]! = response.user?.name?.components(separatedBy: " ")
        var initilas: String = ""
        for name in namesArray {
            initilas += name.prefix(1) + " "
        }
        
        self.userTableData.append(initilas.condensed.uppercased())
        self.userTableData.append(response.user!.familyName!)
        self.userTableData.append(response.user!.givenName!)
        self.userTableData.append(response.user!.name!.condensed.uppercased())
        self.userTableData.append(response.user!.familyName!)
        self.userTableData.append(response.data!.employeeID ?? unavailable )
        
        return userTableData
    }
    
}


