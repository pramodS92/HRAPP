//
//
// BranchInfoServiceManager.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/30/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import Foundation
import Alamofire


protocol OnSuccessBranchInfo {
    func getBranchInfo(response: [String],branchName: String,employeeList: [BranchEmployeeData])
    func OnFailier()
}

class BranchInfoServiceManager {
    
    var brachData = [String]()
    var employeeDataList = [BranchEmployeeData]()
    var delegate: OnSuccessBranchInfo?
    
    public func getBranchInfo(branchName: String,_ callback: OnSuccessBranchInfo) {
        self.delegate = callback
        
        BranchInfoService.shared.getBranchDetailsByName(searchBy: branchName){ [self]
            (response, error, statusCode) in
            if response != nil {
                if let responseBody = try? JSONDecoder().decode(BranchDetailsModel.self, from: response! as! Data){
                    
                    if let infoData = responseBody.data?[0] {
                        brachData.append(infoData.managerName!.condensed.uppercased())
                        brachData.append(infoData.managerKnowName!.uppercased())
                        brachData.append(infoData.managerTelephone!)
                        brachData.append(infoData.addressOne!)
                        brachData.append(infoData.addressTwo!)
                        brachData.append(infoData.addressThree!)
                        brachData.append(infoData.addressFour!)
                        brachData.append(infoData.telephone!)
                        brachData.append(infoData.fax!)
                        brachData.append(infoData.branchID!)
                        brachData.append(infoData.regionalManagerName!.condensed.uppercased())
                        brachData.append(infoData.regionalOffice!)
                        brachData.append(infoData.aGM!.condensed.uppercased())
                        brachData.append(infoData.aGMDesignation!)
                        self.delegate?.getBranchInfo(response: brachData, branchName: infoData.branchName!,employeeList: infoData.branchEmployees!)
                    }
                }
            }else{
                self.delegate?.OnFailier()
                return
            }
        }
    }
    
}
