//
//  SpecialLocationDetailsServiceManager.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-06-18.
//

import Foundation

protocol OnSuccessSpecialLocationDetails {
    func getSpecialLocationInfo(specialLocationName: String, specialLocationInfo: [String])
    func OnFailier()
}

class SpecialLocationDetailsServiceManager {
    
    var delegate: OnSuccessSpecialLocationDetails?
    var specialLocationData: [String] = []
    var specialLocationName: String?
    
    func getSpecialLocationDetailsById(specialLocationId: String,_ callback:OnSuccessSpecialLocationDetails) {
        self.delegate = callback
        
        SpecialLocationInfoService.shared.getSpecialLocationDetailsById(searchBy: specialLocationId) {
            response, error, statusCode in
            if response != nil {
                if let responseBody = try? JSONDecoder().decode(SpecialLocationDetailsModel.self, from: response! as! Data) {
                    if let specialLocationData = responseBody.data {
                        self.delegate?.getSpecialLocationInfo(specialLocationName: specialLocationData.locationName!, specialLocationInfo: self.getSpecialLocationDetails(data: specialLocationData))
                    }
                }
            } else {
                self.delegate?.OnFailier()
                return
            }
        }
        
    }
    
    func getSpecialLocationDetails(data: SpecialLocationDataClass) -> [String] {
        specialLocationData.append(data.nameOne!.condensed.uppercased())
        specialLocationData.append(" ")
        specialLocationData.append(data.directNumberOne!)
        specialLocationData.append(data.interComeOne!)
        specialLocationData.append(data.locationID!)
        specialLocationData.append(data.locationName!)
        specialLocationData.append(data.attachedBranch!)
        specialLocationData.append(data.fax!)
        specialLocationData.append(" ")
        specialLocationData.append(" ")
        specialLocationData.append(" ")
        specialLocationData.append(" ")
        
        return specialLocationData
    }
    
}
