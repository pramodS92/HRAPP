//
//  RegionalOfficeDetailsServiceManager.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-06-16.
//

import Foundation
import Alamofire

protocol onSuccessRegionalOfficeDetails {
    func getRegionalOfficeInfo(regionalOffice: String, regionalOfficeInfo: [String], regionalOfficeEmployeeList: [BranchEmployeeData])
    func OnFailier()
}

class RegionalOfficeDetailsServiceManager {
    
    var delegate: onSuccessRegionalOfficeDetails?
    var regionalOfficeData: [String] = []
    var regionalOffice: String?
    
    func getRegionalOfficeDetailsById(regionalOfficeId: String,_ callback: onSuccessRegionalOfficeDetails) {
        self.delegate = callback
        
        RegionalOfficeInfoService.shared.getRegionalOfficeDetailsById(regionalOfficeId: regionalOfficeId) { (response, error, statusCode) in
            
            if response != nil {
                if let responseBody = try? JSONDecoder().decode(RegionalOfficeDetailsModel.self, from: response! as! Data) {
                    
                    if let regionalOfficeData = responseBody.data {
                        self.delegate?.getRegionalOfficeInfo(regionalOffice: regionalOfficeData.regionalOffice!, regionalOfficeInfo: self.getRegionalOfficeDetails(data: regionalOfficeData), regionalOfficeEmployeeList: regionalOfficeData.employeeDetails!)
                    }
                }
            } else {
                self.delegate?.OnFailier()
                return
            }
        }
        
    }
    
    func getRegionalOfficeDetails(data: RegionalOfficeDataClass) -> [String] {
        
        let location = data.location!
        let address = location.split(separator: ",", maxSplits: 4)
        
        regionalOfficeData.append(data.aGMName!)
        regionalOfficeData.append(data.regionalManagerName!.condensed.uppercased())
        regionalOfficeData.append(data.regionalManagerKnownName!)
        regionalOfficeData.append(data.regionalManagerTP!)
        regionalOfficeData.append(data.regionalManagerEXT!)
        regionalOfficeData.append(data.attachedBranch!)
        regionalOfficeData.append(data.fax!)
        regionalOfficeData.append(String(address[0]))
        regionalOfficeData.append(String(address.count > 1 ? address[1] : ""))
        regionalOfficeData.append(String(address.count > 2 ? address[2] : ""))
        regionalOfficeData.append(String(address.count > 3 ? address[3] : ""))
        
        return regionalOfficeData
    }
}
