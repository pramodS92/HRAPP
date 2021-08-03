//
//
// DepartmentDetailsServiceManager.swift
// HR App
//
//Created by Pramod Ranasinghe on 6/9/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import Foundation
import Alamofire

protocol OnSuccessDepartmentDetails {
    func getDepartmentInfo(departmentName: String, departmentInfo: [String],departmentEmployeeList: [BranchEmployeeData])
    func OnFailier()
}

class DepartmentDetailsServiceManager {
    
    var delegate: OnSuccessDepartmentDetails?
    var departmentData: [String] = []
    var departmentName: String?
    
    func getDepartmentDetailsById(departmentId: String,_ callback:OnSuccessDepartmentDetails ){
        
        self.delegate = callback
        
        DepartmentInfoService.shared.getDepartmentDetailsById(departmentId: departmentId) {
            (response, error, statusCode) in
            if response != nil {
                if let responseBody = try? JSONDecoder().decode(DepartmentDetailsModel.self, from: response! as! Data){
                    if let departmentData = responseBody.data{
                        self.delegate?.getDepartmentInfo(departmentName: departmentData.departmentName!,
                                                         departmentInfo: self.getDepartmentDetails(data: departmentData), departmentEmployeeList: departmentData.branchEmployees!)
                    }
                }
            }else{
                self.delegate?.OnFailier()
                return
            }
        }
    }
    
    
    func getDepartmentDetails(data: DepartmentDataClass)-> [String]{
        departmentData.append(data.deparmentHead!.condensed.uppercased())
        departmentData.append(data.knownName!)
        departmentData.append(data.deparmentHeadTelephone!)
        departmentData.append(data.agmName!.condensed.uppercased())
        departmentData.append(data.branchName!)
        departmentData.append(data.headEXT!)
        departmentData.append(data.fax!)
        departmentData.append(data.addressOne!)
        departmentData.append(data.addressTwo!)
        departmentData.append(data.addressThree!)
        departmentData.append(data.addressFour!)
        
        return departmentData
    }
    
    
    
}
