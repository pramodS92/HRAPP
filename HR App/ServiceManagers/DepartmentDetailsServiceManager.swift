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
    func getDepartmentInfo(response: [String],branchName: String,employeeList: [BranchEmployeeData])
    func OnFailier()
}


class DepartmentDetailsServiceManager {
    
    var delegate: OnSuccessDepartmentDetails?
    
    func getDepartmentDetailsById(departmentId: String){
        
      //  self.delegate = callback
        
        DepartmentInfoService.shared.getDepartmentDetailsById(departmentId: departmentId) {
            (response, error, statusCode) in
            if response != nil {
                if let responseBody = try? JSONDecoder().decode(DepartmentDetailsModel.self, from: response! as! Data){
                   print(".....AAAA  ",responseBody)
                }
            }else{
                return
            }
            
        }
    }
}
