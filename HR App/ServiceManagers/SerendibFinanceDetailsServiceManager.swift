//
//  SerendibFinanceDetailsServiceManager.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-06-17.
//

import Foundation
import Alamofire

protocol onSuccessSerendibFinanceDetails {
    func getSerendibFinanceInfo(serendibFinace: String, serendibFinanceInfo: [String], SerendibFinanceEmployeeList: [BranchEmployeeData])
    func OnFailier()
}

class SerendibFinanceDetailsServiceManager {
    
}
